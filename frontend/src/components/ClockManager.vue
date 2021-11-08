<template>
  <div>
    <div class="button-clock-main">
      <div class="text-clock-main">Cliquez pour commencer votre journée !</div>
      <div class="text-clock-hour" v-if="this.clockIn">
        <v-btn
          class="button-clock"
          elevation="2"
          rounded
          text
          icon
          x-large
          color="white"
          @click="createClock()"
          ><v-icon dark size="50"> mdi-clock </v-icon></v-btn
        >
      </div>
      <div class="text-clock-hour" v-else>
        <v-btn
          class="button-clock-on"
          elevation="2"
          rounded
          text
          icon
          x-large
          color="white"
          @click="createClock()"
          ><v-icon dark size="50"> mdi-clock </v-icon></v-btn
        >
      </div>
      <a class="text-clock-hour" v-if="this.timeElapsed != null">{{
        this.timeElapsed
      }}</a>
      <a class="text-clock-hour" v-else> 0:00 </a>
    </div>
    <!-- 
    <button @click="createClock()" type="button" class="btn btn-primary">
      <div v-if="this.clockIn">Stop Timer</div>
      <div v-else>Start Timer</div>
    </button> -->
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
          console.log("Error getClock", error.message);
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

<style>

.v-application a {
    color: white;
    text-align: center;
    width: 100%;
}

.button-clock-main {
  height: 40vh;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}

.text-clock-main {
  width: 50%;
  margin: auto;
  height: 100px;
  font-size: 1.5em;
  text-align: center;
  font-weight: bold;
}

.button-clock-on {
  width: 50%;
  background-color: #a24936;
  margin: auto;
}

.button-clock-off {
  width: 50%;
  background-color: red;
  margin: auto;
}

.text-clock-hour {
  width: 50%;
  margin: auto;
  text-align: center;
  font-weight: bold;
  font-size: 1.5em;
}

</style>