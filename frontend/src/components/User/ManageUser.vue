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
        <tr v-for="user in this.UserList" :key="user.userID">
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
                userID = user.userID;
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
                      updateUser();
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
                ComfirmationWindow = true;
                deleteID = user.userID;
              "
            >
              <v-icon>mdi-trash-can-outline </v-icon>
            </v-btn>

            <v-dialog
              v-model="ComfirmationWindow"
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
                    @click="ComfirmationWindow = false"
                  >
                    Annuler
                  </v-btn>

                  <v-btn
                    class="mb-3"
                    depressed
                    color="red"
                    @click="
                      deleteUser();
                      ComfirmationWindow = false;
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
      ComfirmationWindow: false,
      EditWindow: false,

      UserList: [
        {
          userID: 1,
          username: "jojo1",
          email: "dede1@gmail.com",
          role: "Admin",
        },
        {
          userID: 2,
          username: "jojo2",
          email: "dede2@gmail.com",
          role: "User",
          userManager:"jojo3"
        },
        {
          userID: 3,
          username: "jojo3",
          email: "dede3@gmail.com",
          role: "Manager",
        },
        {
          userID: 4,
          username: "jojo4",
          email: "dede4@gmail.com",
          role: "User",
          userManager:"jojo3"
        },
      ],
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
      rolePanel: ["Admin", "Manager", "User"],
    };
  },
  methods: {
    getUser() {
      axios
        .get("http://localhost:4000/api/users")
        .then((response) => {
          console.log(response.data);
          // this.UserList = response.data
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    updateUser() {
      axios
        .put(`http://localhost:4000/api/users/${this.userID}/`, {
          email: this.email,
          username: this.username,
        })
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("Error", error.message);
        });
    },
    deleteUser() {
      axios
        .delete("http://localhost:4000/api/users/" + this.deleteID)
        .then((response) => {
          console.log(response.data);
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

<style scoped>
.list {
  width: 50vw;
  height: 80vh;
  display: flex;
  flex-direction: column;
}

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
</style>