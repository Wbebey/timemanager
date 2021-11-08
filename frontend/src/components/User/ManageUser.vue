<template>
  <div class="list">
    <v-simple-table class="blue-grey darken-2">
      <thead>
        <tr>
          <th class="text-left">Nom d’utilisateur</th>
          <th class="text-left">E-mail</th>
          <th class="text-left">Droits</th>
          <th class="text-left">Manager assigné</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in this.UserList" :key="user.id">
          <td>{{ user.id }}</td>
          <td>{{ user.username }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.role }}</td>
          <td>{{ user.userManager }}</td>

          <td>
            <v-btn
              class="my-2"
              color="grey"
              outlined
              fab
              small
              @click="
                EditWindow = true;
                userID = user.id;
                username = user.username;
                email = user.email;
                role = user.role;
              "
            >
              <v-icon>mdi-pencil-outline</v-icon>
            </v-btn>

            <v-dialog
              v-model="EditWindow"
              max-width="350"
              persistent
              :retain-focus="false"
            >
              <v-card class="blue-grey darken-2">
                <v-card-title class="text-h5">
                  Modification de l'utilisateur
                </v-card-title>

                <v-card-body>
                  <div class="mx-5">
                    <v-form ref="form" v-model="valid" lazy-validation>
                      <v-text-field
                        v-model="username"
                        :counter="10"
                        :rules="usernameRules"
                        label="Username"
                        required
                      />

                      <v-text-field
                        v-model="email"
                        :rules="emailRules"
                        label="E-mail"
                        required
                      />

                      <v-select
                        class="blue-grey darken-2"
                        v-model="role"
                        :items="rolePanel"
                        :rules="[(v) => !!v || 'Select permissions']"
                        label="Permissions"
                        outlined
                      />
                    </v-form>
                  </div>
                </v-card-body>

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    class="mb-3"
                    depressed
                    color="grey"
                    @click="EditWindow = false"
                  >
                    Annuler
                  </v-btn>

                  <v-btn
                    class="mb-3"
                    depressed
                    color="green"
                    @click="
                      updateUser(userID);
                      promoteUser(userID);
                      EditWindow = false;
                    "
                  >
                    Modifier
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </td>

          <td>
            <v-btn
              class="my-2"
              color="error"
              outlined
              fab
              small
              @click="
                ConfirmationWindow = true;
                deleteID = user.id;
              "
            >
              <v-icon>mdi-trash-can-outline </v-icon>
            </v-btn>

            <v-dialog
              v-model="ConfirmationWindow"
              max-width="350"
              persistent
              :retain-focus="false"
            >
              <v-card class="blue-grey darken-2">
                <v-card-title class="text-h5">
                  Etes-vous sur(e) de vouloir supprimer cet utilisateur
                  ?</v-card-title
                >

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    class="mb-3"
                    depressed
                    color="grey"
                    @click="ConfirmationWindow = false"
                  >
                    Annuler
                  </v-btn>

                  <v-btn
                    class="mb-3"
                    depressed
                    color="red"
                    @click="
                      deleteUser();
                      ConfirmationWindow = false;
                    "
                  >
                    Supprimer
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </td>
        </tr>
      </tbody>
    </v-simple-table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ManageUser",
  data() {
    return {
      ConfirmationWindow: false,
      EditWindow: false,

      UserList: [],
      deleteID: null,

      valid: true,
      userID: null,
      username: null,
      usernameRules: [
        (v) => !!v || "Username is required",
        (v) => (v && v.length <= 10) || "Name must be less than 10 characters",
      ],
      email: null,
      emailRules: [
        (v) => !!v || "E-mail is required",
        (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
      ],
      role: null,
      rolePanel: ["root", "manager", "employe"],
    };
  },
  mounted() {
    this.getUser();
  },
  methods: {
    getUser() {
      axios
        .get("http://localhost:4000/api/users")
        .then((response) => {
          console.log(response.data);
          this.UserList = response.data;
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    updateUser(userID) {
      axios
        .put(`http://localhost:4000/api/users/${userID}/`, {
          email: this.email,
          username: this.username,
        })
        .then((response) => {
          console.log(response.data);
          this.getUser();
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    promoteUser(userID) {
      if (this.role != null) {
        axios
          .put(`http://localhost:4000/api/users/${userID}/promote/${this.role}`)
          .then((response) => {
            console.log(response.data);
            console.log(this.role);
            this.getUser();
          })
          .catch((error) => {
            console.log("Error", error.message);
            console.log(error.response.data);
          });
      }
    },
    deleteUser() {
      axios
        .delete("http://localhost:4000/api/users/" + this.deleteID)
        .then((response) => {
          console.log(this.deleteID);
          console.log(response.data);
          this.getUser();
        })
        .catch((error) => {
          console.log("Error", error.message);
          this.info = null;
        });
    },
    test() {
      console.log(this.deleteID);
    },
  },
};
</script>

<style>
.v-data-table > .v-data-table__wrapper > table {
  width: 100%;
  height: 100%;
  border-spacing: 0;
}

.list {
  width: 50vw;
  height: 80vh;
  display: flex;
  flex-direction: column;
  color: white;
}

tr:hover td {
  background-color: #3e4c56;
}
</style>