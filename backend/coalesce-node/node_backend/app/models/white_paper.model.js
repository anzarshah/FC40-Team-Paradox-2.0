module.exports = (sequelize, Sequelize) => {
    const Whitepaper = sequelize.define("whitepaper", {

        file_name: {
            type: Sequelize.STRING
        },
        comp_id: {
            type: Sequelize.INTEGER,// <<< Note, its a column name
        }
    });
    return Whitepaper;
};