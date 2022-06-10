module.exports = (sequelize, Sequelize) => {
    const Whitepaper = sequelize.define("whitepaper", {
        white_paper_id: {
            type: Sequelize.INTEGER,
            primaryKey: true
        },
        file_name: {
            type: Sequelize.STRING
        },
        comp_id: {
            type: Sequelize.INTEGER,
            references: {
                model: 'companies',
                key: 'comp_id'
            } // <<< Note, its a column name
        }
    });
    return Whitepaper;
};