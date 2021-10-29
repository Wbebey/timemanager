<template>
  <div>
    <p>WorkingTime View !</p>
    <working-times />
    <clock />
  </div>
</template>

<script>
import WorkingTimes from "../components/WorkingTimes.vue";
import Clock from "../components/ClockManager.vue";

export default {
  name: "WorkingTimesView",
  components: {
    Clock,
    WorkingTimes,
  },
};
</script>

<style scoped>
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