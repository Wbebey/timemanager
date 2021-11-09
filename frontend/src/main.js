import Vue from 'vue'
import App from './App.vue'
import router from './router'
import VueRouter from 'vue-router'
import vuetify from './plugins/vuetify'
import store from './store';

Vue.use(VueRouter)
Vue.config.productionTip = false

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