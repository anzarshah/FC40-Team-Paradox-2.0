module.exports = (sequelize, Sequelize) => {
    const Company = sequelize.define("companies", {
        comp_id: {
            type: Sequelize.INTEGER,
            primaryKey: true
        },
        user_id: {
            type: Sequelize.INTEGER,
            references: {
                model: 'users',
                key: 'id'
            } // <<< Note, its a column name
        },
        name: {
            type: Sequelize.STRING
        },
        email: {
            type: Sequelize.STRING
        },
        password: {
            type: Sequelize.STRING
        },
        verify_flag: {
            type: Sequelize.INTEGER
        },
        ico_creation_flag: {
            type: Sequelize.STRING
        },
    });
    return Company;
};