<template>
  <div class="page-user">
    <div class="clock-side">
      <div class="header-clock-side">
        <img class="logo" :src="logo" />
        <div class="title-user">Bienvenue {{ store_username }}</div>
      </div>
      <div class="button-clock-side">
        <Button_Settings />
      </div>
      <clock v-if="store_role == 'employe' || store_role == 'manager'" />
      <div class="button-clock-second">
        <Button_Employees
          v-if="store_role == 'root' || store_role == 'manager'"
        />
        <Button_Dashboard v-else />
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
        <v-btn icon @click="$refs.calendar.prev()">
          <v-icon color="white">mdi-chevron-left</v-icon>
        </v-btn>
        <div class="v-select-calendar">
          <v-select
            v-model="type"
            :items="types"
            dense
            outlined
            color="white"
            hide-details
            label="type"
          ></v-select>
        </div>
        <v-btn icon @click="$refs.calendar.next()">
          <v-icon color="white">mdi-chevron-right</v-icon>
        </v-btn>
      </div>
      <div class="calendar">
        <v-calendar
          ref="calendar"
          v-model="value"
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
import axios from "axios";
import logo from "../assets/logo.png";
import Clock from "../components/ClockManager.vue";
import Button_Employees from "../components/Button_Employees.vue";
import Button_Settings from "../components/Button_Settings.vue";
import Button_Dashboard from "../components/Button_Dashboard.vue";

import store from "../store";

export default {
  name: "UserView",
  data() {
    return {
      store_role: store.state.user.role,
      store_username: store.state.user.username,
      type: "week",
      types: ["week", "month"],
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
      logo,
      userId: this.$route.params.userId,
    };
  },
  components: {
    Clock,
    Button_Employees,
    Button_Settings,
    Button_Dashboard,
  },
  methods: {
    deconnection() {
      store.state.user.id = undefined;
      store.state.user.username = undefined;
      store.state.user.email = undefined;
      store.state.user.role = undefined;
      this.$router.push("/");
    },
    getEvents() {
      axios
        .get(
          "http://localhost:4000/api/workingtimes/" +
            this.userId +
            "?start=2000-01-01 00:00:00&end=2099-12-31 23:59:59"
        )
        .then((response) => {
          const events = [];
          console.log(response.data);

          for (var element in response.data) {
            console.log(response.data[element]);
            const first = new Date(response.data[element].start);
            const second = new Date(response.data[element].end);

            events.push({
              name: "WorkingTime",
              start: first,
              end: second,
              color: "green",
              timed: true,
            });
          }

          this.events = events;
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
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
.theme--light.v-data-table
  > .v-data-table__wrapper
  > table
  > thead
  > tr:last-child
  > th {
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
  height: 10vh;
  margin-left: 3vw;
}

.title-user {
  font-size: 1em;
  margin-left: 1vw;
}

.header-clock-side {
  height: 20vh;
  width: 100%;
  display: flex;
  align-items: center;
  justify-items: center;
  flex-direction: row;
  font-weight: bold;
  justify-content: start;
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
  width: 60%;
  margin: auto;
  background-color: #a24936;
  font-weight: bold;
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

.v-list-item--dense .v-list-item__title,
.v-list-item--dense .v-list-item__subtitle,
.v-list--dense .v-list-item .v-list-item__title,
.v-list--dense .v-list-item .v-list-item__subtitle {
  font-size: 0.8125rem;
  font-weight: 500;
  line-height: 1rem;
  color: white !important;
  font-weight: bold;
}
</style>