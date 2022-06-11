const { authJwt } = require("../middleware");
const controller = require("../controllers/user.controller");
module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });
    app.post("/api/test/all", controller.allAccess);
    app.post(
        "/api/test/user",
        // [authJwt.verifyToken],
        controller.userBoard
    );
    app.post(
        "/api/test/mod",
        // [authJwt.verifyToken, authJwt.isModerator],
        controller.moderatorBoard
    );
    app.post(
        "/api/test/admin",
        // [authJwt.verifyToken, authJwt.isAdmin],
        controller.adminBoard
    );
};
