<template>
  <div>
    <p>Show WorkingTime Component ! Yes !</p>
    <p v-if="info != null">
      <canvas id="scorechart" width="400" height="400"></canvas>
    </p>
  </div>
</template>

<script>
/*eslint no-unused-vars: 0*/
import axios from "axios";
import { Chart } from "chart.js";

export default {
  name: "ShowUserWorkingTime",
  data() {
    return {
      info: null,
      id: 7,
      start: "2000-01-01 00:00:00",
      end: "2099-12-31 23:59:59",
    };
  },
  mounted: function () {
    this.getWorkingTime();
  },
  methods: {
    getWorkingTime() {
      axios
        .get(
          `http://localhost:4000/api/workingtimes/${this.id}?start=${this.start}&end=${this.end}`
        )
        .then(function (response) {
          const ctx = document.getElementById("scorechart");
          const myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: response.data.map((x) => x.start),
              dataset: [
                {
                  label: "Time in seconds of the interaction",
                  data: response.data.map(
                    (x) => (Date.parse(x.end) - Date.parse(x.start)) / 1000
                  ),
                },
              ],
            },
          });
          this.info = 1;
        });
    },
  },
};
</script>

<style>

</style>