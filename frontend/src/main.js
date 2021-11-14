import Vue from 'vue'
import App from './App.vue'
import router from './router'
import VueRouter from 'vue-router'
import vuetify from './plugins/vuetify'
import store from './store';
import VueApexCharts from 'vue-apexcharts'

Vue.use(VueRouter)
Vue.use(VueApexCharts)
Vue.config.productionTip = false
Vue.component('apexchart', VueApexCharts)

new Vue({
  router,
  store,
  linkActiveClass: "active",
  linkExactActiveClass: "exact-active",
  vuetify,
  icons: {
    iconfont: 'mdiSvg',
  },
  render: h => h(App)
}).$mount('#app')