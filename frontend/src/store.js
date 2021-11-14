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
            workingTimes: [],
            chartUserManager_series: [],
            hours: null,
        }],
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
        setWorkingTimes(state, workingTimes) {
            state.user.workingTimes = workingTimes
        },
        setHours(state, duration) {
            state.user.hours = duration
        },
        setChartUserManager_series(state, series) {
            state.user.chartUserManager_series = series
        }
    },
})

export default store;