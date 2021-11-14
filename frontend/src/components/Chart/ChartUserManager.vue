<template>
  <div>
    <apexchart
      width="500"
      type="line"
      :options="chartOptions"
      :series="series"
    ></apexchart>
    <div>{{ store_hours }}</div>
  </div>
</template>

<script>
import store from "../../store";
import axios from "axios";
import moment from "moment";

export default {
  name: "ChartUserManager",
  data() {
    return {
      store_id: store.state.user.id,
      store_workingTimes: store.state.user.workingTimes,
      store_hours: store.state.user.hours,
      start: "2000-01-01 00:00:00",
      end: "2099-12-31 23:59:59",
      chartOptions: {
        chart: {
          id: "user-line",
        },
        xaxis: {
          categories: [
            "Lundi",
            "Mardi",
            "Mercredi",
            "Jeudi",
            "Vendredi",
            "Samedi",
            "Dimanche",
          ],
        },
      },
      series: [
        {
          name: "Temps de travail",
          data: [],
        },
      ],
    };
  },
  methods: {
    getWorkingTimeUser() {
      var days = [
        "Lundi",
        "Mardi",
        "Mercredi",
        "Jeudi",
        "Vendredi",
        "Samedi",
        "Dimanche",
      ];
      axios
        .get(
          `http://localhost:4000/api/workingtimes/${this.store_id}?start=${this.start}&end=${this.end}`
        )
        .then(function (response) {
          var newhours = [0, 0, 0, 0, 0, 0, 0];
          var days_counter = [0, 0, 0, 0, 0, 0, 0];
          store.commit("setWorkingTimes", response.data);
          store.state.user.workingTimes.forEach((e) => {
            var start = moment(e.start);
            var end = moment(e.end);
            var duration = moment.duration(end.diff(start));
            newhours[start.isoWeekday() - 1] += Math.round(duration.asHours());
            console.log(days[start.isoWeekday() - 1]);
            console.log(newhours[start.isoWeekday() - 1]);
            console.log(start.isoWeekday() - 1);
            days_counter[start.isoWeekday() - 1] += 1;
          });
          for (var i = 0; i != 6; i++)
            newhours[i] = newhours[i] / days_counter[i];
          console.log(newhours);
          console.log(days_counter);
          series = [
            {
              name: "Temps de travail",
              data: newhours,
            },
          ];
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
  },
  mounted() {
    this.getWorkingTimeUser();
  },
};
</script>

<style>
.apexcharts-tooltip.apexcharts-theme-light .apexcharts-tooltip-title {
  background: #4c5c68;
  border-bottom: 1px solid #4c5c68;
}

.apexcharts-tooltip.apexcharts-theme-light {
  border: 1px solid #4c5c68;
  background: #4c5c68;
}

.apexcharts-xaxistooltip {
  opacity: 0;
  padding: 9px 10px;
  pointer-events: none;
  color: #4c5c68;
  font-size: 13px;
  text-align: center;
  border-radius: 2 px;
  position: absolute;
  z-index: 10;
  background: #4c5c68;
  border: 1 px solid #4c5c68;
  transition: 0.15s ease all;
}
</style>