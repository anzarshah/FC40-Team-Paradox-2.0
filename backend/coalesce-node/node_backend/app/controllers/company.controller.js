const db = require("../models");
const config = require("../config/auth.config");
const Company = db.company;
const Role = db.role;
const Op = db.Sequelize.Op;
var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");
exports.data = (req, res) => {
    console.log(req.body)
    Company.create({
        user_id: req.body.user_id,
        name: req.body.name,
    })
        .then(
            res.send({ message: "Request posted" })
        )
        .catch(err => {
            res.status(500).send({ message: err.message });
        });
};

exports.data = (req, res) => {
    // Save User to Database
    Company.create({
        user_id: req.body.user_id,
        name: req.body.name,
        whitepaper_check: 0,
        approval_check: 0,
        accept_deny_check: 0,
        ico_creation_flag: 0,
    }).then(roles => {
        user.setRoles(roles).then(() => {
            res.send({ message: "Company was registered successfully!" });
        });
    })


        .catch(err => {
            res.status(500).send({ message: err.message });
        });
};

// exports.get = (req, res) => {
//     // Save User to Database
//     // var sdf = Company.findOne({
//     //     user_id: req.body.user_id,
//     // }).then(
//     //         // res.send({ message: "user Data!"})
//     // )
//     // res.send({ message: sdf})


//     //     .catch(err => {
//     //         res.status(500).send({ message: err.message });
//     //     });



//         Company.findOne({
//             where: {
//                 user_id: req.body.user_id
//             }
//         })
//             .then(comp => {
//                     res.status(200).send({
//                         data: Company.findOne({
//                             where: {
//                                 user_id: req.body.user_id
//                             }
//                         })
//                     });
//             })
//             .catch(err => {
//                 res.status(500).send({ message: err.message });
//             });
// };

exports.get = (req, res) => {
    const id = req.body.user_id
  
    Company.findOne({
        where: {
            user_id: req.body.user_id
        }
    })
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message: "Error retrieving Tutorial with id=" + id
        });
      });
  };

