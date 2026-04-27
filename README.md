# Luau Scripts Collection

A set of Roblox (Luau) scripts for spawning jets, dropping bombs, and handling a nuke explosion system.

---

## Scripts

* **ToolActivateLocal**
  Handles camera movement, raycasting, and fires the RemoteEvent.

* **GrantRadio**
  Gives the Radio tool to a player.

* **ExplodeNuke**
  Detects parts in a radius, unanchors them, breaks joints, and creates an explosion.

* **SpawnBombAndJet**
  Spawns and moves a jet toward a target position, drops bombs midway, then continues forward.

---

## Setup / Usage

1. Place **ToolActivateLocal** inside a Tool named `Radio` in `ServerStorage`.

2. Place:

   * `SpawnBombAndJet`
   * `GrantRadio`
     inside `ServerScriptService`.

3. Put **ExplodeNuke** inside a folder containing your nuke models.

   * ⚠️ Models must have a valid `CFrame`.

4. In `ReplicatedStorage`:

   * Create a folder called `RemoteEvents`
   * Add a `RemoteEvent` named `DropBomb`

5. In `Workspace`:

   * Add the nuke model and name it `TemplateNuke`
   * Create two parts:

     * `jetLookAt`
     * `jetPos`
   * Add a model named `NukePlane` (used for bomb dropping)

---

# Example

![Demo](demo.gif)

## Notes

* Tested in Roblox Studio


Copy the Nuke model into the workspace and name it "TemplateNuke"

Create two parts called "jetLookAt" and "jetPos"

Create a model called "NukePlane", this will be the model which drops the bombs

## Notes
Tested in Roblox Studio.
