<template>
  <div>
    <h1>Clock Manager</h1>
    <p>{{ this.timeElapsed }}</p>
    <button @click="createClock()" type="button" class="btn btn-primary">
      <div v-if="this.clockIn">Stop Timer</div>
      <div v-else>Start Timer</div>
    </button>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  name: "ClockManager",
  data() {
    return {
      info: null,
      timeElapsed: null,
      userID: this.$route.params.userId,
      startDateTime: null,
      clockIn: false,
    };
  },
  created() {
    setInterval(this.getNow, 1000);
  },
  methods: {
    getNow() {
      if (!this.clockIn) {
        this.timeElapsed = null;
        return;
      }
      var startDate = new Date(this.startDateTime);
      this.timeElapsed = moment(startDate).fromNow();
    },
    getClock() {
      axios
        .get("http://localhost:4000/api/clocks/" + this.userID)
        .then((response) => {
          console.log(response.data);
          this.startDateTime = response.data.time;
          this.clockIn = response.data.status;
        })
        .catch((error) => {
          console.log("Error", error.message);
          this.info = null;
        });
    },
    createClock() {
      axios
        .post("http://localhost:4000/api/clocks/" + this.userID)
        .then((response) => {
          console.log(response.data);
          if (response.data == "First clock initialised") this.createClock();
          else this.getClock();
        })
        .catch((error) => {
          console.log("Error", error.message);
          this.info = null;
        });
    },
  },
  mounted() {
    this.getClock();
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