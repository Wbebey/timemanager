<template>
  <v-dialog width="60vw" height="60vh">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        class="button-employees"
        elevation="2"
        text
        rounded
        color="white"
        v-bind="attrs"
        v-on="on"
        @click="getWorkingTimeUser()"
      >
        Dashboard</v-btn
      >
    </template>
    <div class="popup">
      <chart-manager class="chart-manager" />
    </div>
  </v-dialog>
</template>

<script>
import moment from "moment";
import ChartManager from "./Chart/ChartManager.vue";
import axios from "axios";
import store from "../store";

export default {
  name: "Button_Dashboard",
  components: {
    ChartManager,
  },
  data() {
    return {
      store_id: store.state.user.id,
      start: "2000-01-01 00:00:00",
      end: "2099-12-31 23:59:59",
    };
  },
  methods: {
    getWorkingTimeUser() {
      axios
        .get(
          `http://localhost:4000/api/workingtimes/${this.store_id}?start=${this.start}&end=${this.end}`
        )
        .then(function (response) {
          var hours = [];
          store.commit("setWorkingTimes", response.data);
          store.state.user.workingTimes.forEach((e) => {
            var start = moment(e.start);
            var end = moment(e.end);
            var duration = moment.duration(end.diff(start));
            hours.push(duration.asHours());
          });
          store.commit("setHours", hours);
          console.log(store.state.user.hours);
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
  },
};
</script>

<style scoped>
.popup {
  display: flex;
  flex-direction: row;
}
</style>