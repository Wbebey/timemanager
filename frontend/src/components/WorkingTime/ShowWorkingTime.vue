<template>
  <div>
    <v-card
      elevation="2"
      class="d-inline-flex pa-2"
      max-width="400px"
      outlined
      tile
    >
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="text-h5 mb-3"
            >Selection des périodes de travail</v-list-item-title
          >
          <v-list-item-subtitle>
            <input
              class="text-overline mb-1"
              v-model="start"
              type="datetime-local"
              id="start"
            />
          </v-list-item-subtitle>
          <v-list-item-subtitle>
            <input
              class="text-overline mb-1"
              v-model="end"
              type="datetime-local"
              id="end"
            />
          </v-list-item-subtitle>

          <v-list-item-subtitle>
            <v-btn
              elevation="2"
              outlined
              color="accent"
              @click="getWorkingTime()"
            >
              Confirmer
            </v-btn>
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-card>

    <v-card
      v-if="this.info"
      elevation="2"
      class="d-inline-flex pa-2"
      outlined
      tile
    >

          

  <v-simple-table>
      <tbody>
        <tr
          v-for="workingtime in this.info"
        :key="workingtime.start"
        @click="test(workingtime)"
        >
          <td> {{ workingtime.start }} ==> {{ workingtime.end }} </td>
        </tr>
      </tbody>
  </v-simple-table>


    </v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ShowWorkingTime",
  data() {
    return {
      info: null,
      id: null,
    };
  },
  methods: {
    getWorkingTime() {
      axios
        .get(
          `http://localhost:4000/api/workingtimes/${
            this.$route.params.userId
          }?start=${this.start.replace("T", " ")}:00&end=${this.end.replace(
            "T",
            " "
          )}:00`
        )
        .then((response) => (this.info = response.data))
        .catch((error) => {
          console.log("Error", error.message);
          this.info = null;
        });
    },
    test(id) {
      console.log(id);
    },
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