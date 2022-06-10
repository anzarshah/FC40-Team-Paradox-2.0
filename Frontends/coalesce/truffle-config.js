// require('babel-register');
// require('babel-polyfill');

module.exports = {

    networks:{
        development:{
            network_id:'*', //connect to network
            host:'192.168.24.228',
            port:'7545',

        },
        advanced: {
            websockets: true,
        }
    },

    contracts_build_directory: "./src/abis/",
    compilers:{
        solc:{
            version: '^0.5.0',
            optimizer : {
                enable: true,
                runs:200

            }

        }
    }


}