<template>
  <div class="list">
    <v-data-iterator
      class="blue-grey darken-2"
      :items="info"
      disable-filtering
      disable-sort
    >
      <template v-slot:header>
        <v-toolbar class="blue-grey darken-2" dark flat>
          <v-toolbar-title>
            <v-btn
              class="ma-3 blue-grey darken"
              depressed
              color="orange"
              @click="ConfirmationWindowAddTeam = true"
            >
              Creer une nouvelle équipe
            </v-btn>

            <v-dialog
              v-model="ConfirmationWindowAddTeam"
              max-width="330"
              persistent
              :retain-focus="false"
            >
              <v-card class="blue-grey darken-2">
                <v-card-title class="text-h5">
                  Entrez le nom de l'équipe que vous voulez creer
                  :</v-card-title
                >
                <v-text-field
                  class="mx-5"
                  v-model="CreateTeamName"
                  label="Name"
                  required
                />
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    class="mb-3"
                    depressed
                    color="grey"
                    @click="
                      ConfirmationWindowAddTeam = false;
                      CreateTeamName = null;
                    "
                  >
                    Annuler
                  </v-btn>

                  <v-btn
                    class="mb-3"
                    depressed
                    color="orange"
                    @click="
                      createTeam();
                      ConfirmationWindowAddTeam = false;
                      CreateTeamName = null;
                    "
                  >
                    Ajouter
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog></v-toolbar-title
          >
        </v-toolbar>
      </template>

      <template v-slot:default="props">
        <v-row class="menuTeam">
          <v-col
            v-for="item in props.items"
            :key="item.name"
            cols="12"
            sm="6"
            md="4"
            lg="3"
          >
            <v-card class="blue-grey darken-1 ma-3">
              <v-card-title class="blue-grey darken-1">
                <td>
                  {{ item.name }}

                  <v-btn
                    class="mx-1"
                    color="orange"
                    outlined
                    fab
                    small
                    @click="
                      ConfirmationWindowAddUser = true;
                      memberToAddTeamID = item.id;
                    "
                  >
                    <v-icon>mdi-account-multiple-plus-outline</v-icon>
                  </v-btn>

                  <v-dialog
                    v-model="ConfirmationWindowAddUser"
                    max-width="350"
                    persistent
                    :retain-focus="false"
                  >
                    <v-card class="blue-grey darken-2">
                      <v-card-title class="text-h5">
                        id de l'utilisateur à ajouter :</v-card-title
                      >
                      <v-text-field
                        class="mx-5"
                        v-model="memberToAddID"
                        type="number"
                        label="Id"
                        required
                      />
                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn
                          class="mb-3"
                          depressed
                          color="grey"
                          @click="
                            ConfirmationWindowAddUser = false;
                            memberToAddID = null;
                          "
                        >
                          Annuler
                        </v-btn>

                        <v-btn
                          class="mb-3"
                          depressed
                          color="orange"
                          @click="
                            addUserToTeam();
                            ConfirmationWindowAddUser = false;
                            memberToAddID = null;
                          "
                        >
                          Ajouter
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-dialog>

                  <v-btn
                    class="ml-2"
                    color="error"
                    outlined
                    fab
                    small
                    @click="
                      ConfirmationWindowDeleteTeam = true;
                      deleteTeamID = item.id;
                    "
                  >
                    <v-icon>mdi-trash-can-outline </v-icon>
                  </v-btn>

                  <v-dialog
                    v-model="ConfirmationWindowDeleteTeam"
                    max-width="350"
                    persistent
                    :retain-focus="false"
                  >
                    <v-card class="blue-grey darken-2">
                      <v-card-title class="text-h5">
                        Etes-vous sur(e) de vouloir supprimer cette équipe
                        ?</v-card-title
                      >

                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn
                          class="mb-3"
                          depressed
                          color="grey"
                          @click="ConfirmationWindowDeleteTeam = false"
                        >
                          Annuler
                        </v-btn>

                        <v-btn
                          class="mb-3"
                          depressed
                          color="red"
                          @click="
                            deleteTeam();
                            ConfirmationWindowDeleteTeam = false;
                          "
                        >
                          Supprimer
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-dialog>
                </td>
              </v-card-title>

              <v-divider></v-divider>

              <v-list
                class="blue-grey darken-1"
                v-for="member in item.members"
                :key="member.id"
              >
                <v-list-item>
                  <v-list-item-content>
                    <td>
                      <v-btn
                        color="error"
                        outlined
                        fab
                        small
                        @click="
                          ConfirmationWindowDeleteMemeber = true;
                          deleteFromTeamID = item.id;
                          deleteID = member.id;
                        "
                      >
                        <v-icon>mdi-close</v-icon>
                      </v-btn>

                      <v-dialog
                        v-model="ConfirmationWindowDeleteMemeber"
                        max-width="350"
                        persistent
                        :retain-focus="false"
                      >
                        <v-card class="blue-grey darken-2">
                          <v-card-title class="text-h5">
                            Etes-vous sur(e) de vouloir supprimer cet
                            utilisateur de l'équipe ?</v-card-title
                          >

                          <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn
                              class="mb-3"
                              depressed
                              color="grey"
                              @click="ConfirmationWindowDeleteMemeber = false"
                            >
                              Annuler
                            </v-btn>

                            <v-btn
                              class="mb-3"
                              depressed
                              color="red"
                              @click="
                                deleteUserFromTeam();
                                ConfirmationWindowDeleteMemeber = false;
                              "
                            >
                              Supprimer
                            </v-btn>
                          </v-card-actions>
                        </v-card>
                      </v-dialog>
                      {{ member.username }}
                    </td>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-card>
          </v-col>
        </v-row>
      </template>
    </v-data-iterator>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "TeamsManager",
  data() {
    return {
      members: null,
      info: [],

      memberToAddID: null,
      memberToAddTeamID: null,
      ConfirmationWindowAddUser: null,

      deleteFromTeamID: null,
      deleteID: null,
      ConfirmationWindowDeleteMemeber: false,

      CreateTeamName: null,
      ConfirmationWindowAddTeam: null,

      deleteTeamID: null,
      ConfirmationWindowDeleteTeam: false,
    };
  },
  methods: {
    getTeams() {
      var info = [];
      axios
        .get(`http://localhost:4000/api/teams/`)
        .then(async function (response) {
          for (var team of response.data) {
            await axios
              .get(`http://localhost:4000/api/teams/${team.id}/users`)
              .then(function (response) {
                info.push({
                  id: team.id,
                  name: team.name,
                  members: response.data,
                });
              })
              .catch((error) => {
                console.log("Error", error.message);
              });
          }
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
      this.info = info;
    },
    addUserToTeam() {
      axios
        .post(
          `http://localhost:4000/api/teams/${this.memberToAddTeamID}/users/${this.memberToAddID}`
        )
        .then((response) => {
          console.log(response.data);
          this.getTeams();
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },

    deleteUserFromTeam() {
      axios
        .delete(
          `http://localhost:4000/api/teams/${this.deleteFromTeamID}/users/${this.deleteID}`
        )
        .then((response) => {
          console.log(response.data);
          this.getTeams();
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    createTeam() {
      axios
        .post(`http://localhost:4000/api/teams/?name=${this.CreateTeamName}`)
        .then((response) => {
          console.log(response.data);
          this.getTeams();
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    deleteTeam() {
      axios
        .delete(`http://localhost:4000/api/teams/${this.deleteTeamID}`)
        .then((response) => {
          console.log(response.data);
          this.getTeams();
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
  },
  mounted() {
    this.getTeams();
  },
};
</script>

<style scoped>
.v-data-table > .v-data-table__wrapper > table {
  width: 100%;
  height: 100%;
  border-spacing: 0;
}

.list {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  color: white;
}

tr:hover td {
  background-color: #3e4c56;
}

@media screen and (min-width: 768px) {
  .menuTeam{
    height:90vh !important;
  }
}

</style>