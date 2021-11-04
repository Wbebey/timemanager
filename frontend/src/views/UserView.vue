<template>
  <div class="action">
      <get-user />
    <clock />
      <show-working-times />

  </div>
</template>

<script>
import GetUser from '../components/User/GetUser.vue'
import ShowWorkingTimes from '../components/WorkingTime/ShowWorkingTime.vue'
import Clock from "../components/ClockManager.vue";

export default {
  name: 'UserView',
  data() {
    return {
      userId: this.$route.params.userId,
      username: null,
      email: null,
    };
  },
  components: {
    GetUser,
    Clock,
    ShowWorkingTimes,
  }
}
</script>

<style scoped>
.action {
    display: flex;
    align-items: center;
    justify-content: center;
    justify-content: space-evenly;
    flex-direction: column;
    height: 70vh;
}
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>