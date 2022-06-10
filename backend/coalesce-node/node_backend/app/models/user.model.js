module.exports = (sequelize, Sequelize) => {
    const User = sequelize.define("users", {
        // user_id: {
        //     type: Sequelize.INTEGER,
        //     primaryKey: true
        // },
        username: {
            type: Sequelize.STRING
        },
        email: {
            type: Sequelize.STRING
        },
        password: {
            type: Sequelize.STRING
        },
        role: {
            type: Sequelize.INTEGER,
            references: {
                model: 'roles',
                key: 'id'
            } // <<< Note, its a column name
        }
    });
    return User;
};