module.exports = (sequelize, Sequelize) => {
    const ico = sequelize.define("icos", {
        ico_name: {
            type: Sequelize.STRING
        },
        comp_id: {
            type: Sequelize.INTEGER,// <<< Note, its a column name
        },
        volume: {
            type: Sequelize.STRING
        },
    });
    return ico;
};