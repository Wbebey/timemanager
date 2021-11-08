<template>
  <div class="page-user">
    <div class="clock-side">
      <div class="header-clock-side">
        <img class="logo" :src="logo" />
        <div class="title-user">Bienvenue Lucas Guyader</div>
      </div>
      <div class="button-clock-side">
        <Button_Settings />
      </div>
      <clock />
      <div class="button-clock-second">
        <Button_Employees />
        <v-btn
          class="button-employees"
          elevation="2"
          text
          rounded
          color="white"
          @click="deconnection()"
          >Deconnexion</v-btn
        >
      </div>
    </div>
    <div class="calendar-side">
      <div class="header-calendar-size">
        <v-btn icon class="ma-2" @click="$refs.calendar.prev()">
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
        <v-select
          v-model="type"
          :items="types"
          dense
          outlined
          hide-details
          class="ma-2"
          label="type"
        ></v-select>
        <v-btn icon class="ma-2" @click="$refs.calendar.next()">
          <v-icon>mdi-chevron-right</v-icon>
        </v-btn>
      </div>
      <div class="calendar">
        <v-calendar
          ref="calendar"
          v-model="value"
          :weekdays="weekday"
          :type="type"
          :events="events"
          :event-overlap-threshold="30"
          :event-color="getEventColor"
          @change="getEvents"
        ></v-calendar>
      </div>
    </div>
  </div>
</template>

<script>
//import GetUser from "../components/User/GetUser.vue";
//import ShowWorkingTimes from "../components/WorkingTime/ShowWorkingTime.vue";
//import Clock from "../components/ClockManager.vue";
import logo from "../assets/logo.png";
import Clock from "../components/ClockManager.vue";
import Button_Employees from "../components/Button_Employees.vue";
import Button_Settings from "../components/Button_Settings.vue";

export default {
  name: "UserView",
  data() {
    return {
      type: "month",
      types: ["month", "week"],
      weekday: [0, 1, 2, 3, 4, 5, 6],
      weekdays: [
        { text: "Sun - Sat", value: [0, 1, 2, 3, 4, 5, 6] },
        { text: "Mon - Sun", value: [1, 2, 3, 4, 5, 6, 0] },
        { text: "Mon - Fri", value: [1, 2, 3, 4, 5] },
        { text: "Mon, Wed, Fri", value: [1, 3, 5] },
      ],
      value: "",
      events: [],
      colors: [
        "blue",
        "indigo",
        "deep-purple",
        "cyan",
        "green",
        "orange",
        "grey darken-1",
      ],
      names: [
        "Meeting",
        "Holiday",
        "PTO",
        "Travel",
        "Event",
        "Birthday",
        "Conference",
        "Party",
      ],
      logo,
      userId: this.$route.params.userId,
      username: null,
      email: null,
    };
  },
  components: {
    //GetUser,
    Clock,
    Button_Employees,
    Button_Settings,
    //ShowWorkingTimes,
  },
  methods: {
    deconnection() {
      //axios
      //  .post("http://localhost:4000/api/users/", {
      //    email: this.email,
      //    username: this.username,
      //  })
      //  .then((response) => {
      //    console.log(response.data);
      this.$router.push("/");
      //  })
      //  .catch((error) => {
      //    console.log("Error", error.message);
      //  });
    },
    getEvents({ start, end }) {
      const events = [];

      const min = new Date(`${start.date}T00:00:00`);
      const max = new Date(`${end.date}T23:59:59`);
      const days = (max.getTime() - min.getTime()) / 86400000;
      const eventCount = this.rnd(days, days + 20);

      for (let i = 0; i < eventCount; i++) {
        const allDay = this.rnd(0, 3) === 0;
        const firstTimestamp = this.rnd(min.getTime(), max.getTime());
        const first = new Date(firstTimestamp - (firstTimestamp % 900000));
        const secondTimestamp = this.rnd(2, allDay ? 288 : 8) * 900000;
        const second = new Date(first.getTime() + secondTimestamp);

        events.push({
          name: this.names[this.rnd(0, this.names.length - 1)],
          start: first,
          end: second,
          color: this.colors[this.rnd(0, this.colors.length - 1)],
          timed: !allDay,
        });
      }

      this.events = events;
    },
    getEventColor(event) {
      return event.color;
    },
    rnd(a, b) {
      return Math.floor((b - a + 1) * Math.random()) + a;
    },
  },
};
</script>

<style>

.theme--light.v-data-table > .v-data-table__wrapper > table > thead > tr:last-child > th {
    border-bottom: thin solid rgba(0, 0, 0, 0.12);
    color: white !important;
    font-size: 1em;
}

.v-sheet.v-card {
  border-radius: 0px !important;
}

.v-data-table {
  border-radius: 0px !important;
}

.v-dialog {
  border-radius: 20px;
  margin: 24px;
  overflow-y: auto;
  pointer-events: auto;
  transition: 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  width: 100%;
  z-index: inherit;
  box-shadow: 0px 11px 15px -7px rgb(0 0 0 / 20%),
    0px 24px 38px 3px rgb(0 0 0 / 14%), 0px 9px 46px 8px rgb(0 0 0 / 12%);
}

.theme--light.v-list {
  background: #4c5c68 !important;
  color: rgba(0, 0, 0, 0.87);
}

.v-list-item--dense .v-list-item__title,
.v-list-item--dense .v-list-item__subtitle,
.v-list--dense .v-list-item .v-list-item__title,
.v-list--dense .v-list-item .v-list-item__subtitle {
  font-size: 0.8125rem;
  font-weight: 500;
  line-height: 1rem;
  color: black !important;
}

.v-btn--rounded {
  border-radius: 100px !important;
}

.v-btn--icon.v-size--x-large {
  height: 100px !important;
  width: 100px !important;
}

.page-user {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: row;
  background-color: #4c5c68;
}

.clock-side {
  width: 25vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.calendar-side {
  width: 75vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: grey;
}

.logo {
  border-radius: 90%;
  height: 15vh;
}

.title-user {
  font-size: 1.5em;
}

.header-clock-side {
  height: 20vh;
  width: 100%;
  display: flex;
  align-items: center;
  justify-items: center;
  flex-direction: row;
  font-weight: bold;
  justify-content: center;
}

.button-clock-side {
  height: 6vh;
  width: 100%;
}

.button-clock-side-elem {
  background-color: #a24936;
  margin-left: 45px;
}

.button-clock-main {
  height: 40vh;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}

.button-clock-second {
  height: 35vh;
  width: 100%;
  display: flex;
  flex-direction: column;
}

.button-employees {
  width: 50%;
  margin: auto;
  background-color: #a24936;
}

.header-calendar-size {
  height: 15vh;
  width: 100%;
  display: flex;
  flex-direction: row;
  align-items: center;
  background-color: #4c5c68;
}

.button-calendar {
  width: 20%;
  margin: auto;
  background-color: #a24936;
}

.calendar {
  width: 100%;
  height: 85vh;
}
</style>