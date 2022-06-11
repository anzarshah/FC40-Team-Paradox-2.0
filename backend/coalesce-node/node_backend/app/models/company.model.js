module.exports = (sequelize, Sequelize) => {
    const Company = sequelize.define("companies", {

        user_id: {
            type: Sequelize.INTEGER,// <<< Note, its a column name
        },
        name: {
            type: Sequelize.STRING
        },
        whitepaper_check: {
            type: Sequelize.INTEGER,
            defaultValue: 0
        },
        approval_check: {
            type: Sequelize.INTEGER,
            defaultValue: 0
        },
        accept_deny_check: {
            type: Sequelize.INTEGER,
            defaultValue: 0
        },
        ico_creation_flag: {
            type: Sequelize.INTEGER,
            defaultValue: 0
        },
    });
    return Company;
};