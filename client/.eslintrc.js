module.exports = {
    "env": {
        "es2021": true,
        "browser": true,
        "node": true,
        "jest": true,
    },
    "extends": [
        "eslint:recommended",
        "plugin:react/recommended"
    ],
    "parserOptions": {
        "ecmaFeatures": {
            "jsx": true
        },
        "ecmaVersion": "latest",
        "sourceType": "module"
    },
    "plugins": [
        "react"
    ],
    "rules": {
        "semi": ["error", "always"],
    },
    "settings":{
        "react":{
            "version": 'detect'
        }
    }
};
