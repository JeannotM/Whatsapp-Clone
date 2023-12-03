const WebSocket = require("ws");
const wss = new WebSocket.Server({ remoteAddress: "localhost", port: 8080 });

let userAmount = 1;
const sockets = {};

function to(user, data) {
    if(sockets[user] && sockets[user].ws.readyState === WebSocket.OPEN)
        sockets[user].send(data);
}

wss.on('connection', function connection(ws, req) {
    const userId = userAmount++;
    const data = {
        "isFirstTime": 1, "userId": userId,
    }
    ws.send(JSON.stringify(data));

    ws.on("message", data => {
        let json = JSON.parse(data.toString());
        
        if(json.emit === "userRegister") {
            json.userId = userId;
            sockets[userId].userData = json;
            ws.emit("userRegister", JSON.stringify(json));
        }
    });


    ws.on("userRegister", data => {
        ws.send(data.toString());
    });


    ws.on("close", data => {
        delete sockets[userId];
    });

    sockets[userId] = {ws: ws};
});
