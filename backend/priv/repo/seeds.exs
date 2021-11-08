# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManagerAPI.Repo.insert!(%TimeManagerAPI.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

### USERS ###

root =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.User{
    email: "admin@CGT-U.com",
    username: "Admin",
    role: :root
  })

gardener_chief =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.User{
    email: "gardener@gotham.city",
    username: "Main gardener",
    role: :manager
  })

gardener =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.User{
    email: "jackson.mitchel@gotham.city",
    username: "Jackson Mitchel"
  })

commisar =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.User{
    email: "commisar@gcpd.com",
    username: "Commisar of the Gotham City Police Department",
    role: :manager
  })

cop1 =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.User{
    email: "car1@gcpd.com",
    username: "Car 1"
  })

cop2 =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.User{
    email: "car2@gcpd.com",
    username: "Car 2"
  })

### TEAMS ###

gardening_team =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.Team{
    name: "Gardening team"
  })
  |> TimeManagerAPI.Repo.preload(:users)

police =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.Team{
    name: "Police Department"
  })
  |> TimeManagerAPI.Repo.preload(:users)

### TEAMS ASSOCIATIONS ###

gardening_team =
  gardening_team
  |> Ecto.Changeset.change()
  |> Ecto.Changeset.put_assoc(:users, [root, gardener_chief, gardener])
  |> TimeManagerAPI.Repo.update()

police =
  police
  |> Ecto.Changeset.change()
  |> Ecto.Changeset.put_assoc(:users, [root, commisar, cop1, cop2])
  |> TimeManagerAPI.Repo.update()

### WORKING TIMES ###

cop1_day_1 =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.Workingtime{
    user: cop1,
    start: ~N[2021-11-01 10:04:12],
    end: ~N[2021-11-01 18:15:42]
  })

cop1_day_2 =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.Workingtime{
    user: cop1,
    start: ~N[2021-11-02 10:01:33],
    end: ~N[2021-11-02 17:56:25]
  })

cop2_day_1 =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.Workingtime{
    user: cop2,
    start: ~N[2021-11-01 09:53:16],
    end: ~N[2021-11-01 18:04:01]
  })

cop2_day_2 =
  TimeManagerAPI.Repo.insert!(%TimeManagerAPI.Workingtime{
    user: cop2,
    start: ~N[2021-11-02 09:59:18],
    end: ~N[2021-11-02 18:30:55]
  })
