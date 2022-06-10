module.exports = (sequelize, Sequelize) => {
    const ico = sequelize.define("icos", {
        ico_id: {
            type: Sequelize.INTEGER,
            primaryKey: true
        },
        ico_name: {
            type: Sequelize.STRING
        },
        comp_id: {
            type: Sequelize.INTEGER,
            references: {
                model: 'companies',
                key: 'comp_id'
            } // <<< Note, its a column name
        },
        volume: {
            type: Sequelize.STRING
        },
    });
    return ico;
};