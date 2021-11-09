import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

const store = new Vuex.Store({
    state: {
        user: [{
            id: 0,
            username: null,
            email: null,
            role: null,
        }]
    },
    mutations: {
        setId(state, id) {
            state.user.id = id
        },
        setUsername(state, username) {
            state.user.username = username
        },
        setEmail(state, email) {
            state.user.email = email
        },
        setRole(state, role) {
            state.user.role = role
        },
        getAll (state) {
            console.log(state.user)
        },
    }
})

export default store;