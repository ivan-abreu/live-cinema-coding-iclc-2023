![LIVE CINEMA CODING | AUTOCONSTRUCCION | ICLC 2023](https://livecinemacoding.xyz/images/livecinemacoding-iclc2023-01.jpg "LIVE CINEMA CODING | AUTOCONSTRUCCION | ICLC 2023")
###### Audiovisual concert controlling Unreal Engine from Tidal Cycles | ICLC 2023, Utrecht, The Netherlands

<dl>
<br>
</dl>

##### *ICLC 2023*
# Live Cinema Coding 
### Ussing **Tidal Cycles**, **Processing** and **Unreal Engine**
##### by **Malitzin Cortes (CNDSD)** and **Ivan Abreu**
#

We define Live Cinema Coding as a performative practice (heir to Live cinema) that uses live coding to
sequence cinematographic shots, transform a 3D scene, animate actors, control light, process videos, etc.
We use the pattern strength of Tidal to create sound-visual synesthesia and music visualization by refactoring
musical patterns into visual patterns.



### 1. Tidal Cycles
<a href="https://tidalcycles.org/" target="_blank">Tidal Cycles</a> is a free/open source software, that allows you to make patterns with code, whether live coding music at algoraves or composing in the studio, created by Alex McLean.

### 2. Processing
<a href="https://processing.org/download" target="_blank">Processing</a> is a free/open source software, very flexible and focus mostly in interactive visual arts. In this case es used as a bridget between Tidal Cycles and Unreal Engine.

### 3. Unreal Engine
<a href="https://www.unrealengine.com/en-US/download" target="_blank">Unreal Engine</a> is a game engine for 3D creation in real time.

<dl>
  <br>
</dl>

CAMERAS DEMO (from scratch):

[![SC2 Video](https://livecinemacoding.xyz/images/workshop-livecinemacoding-cameras.png)](https://livecinemacoding.xyz/videos/workshop-livecinemacoding-cameras.mp4 "Click to play >") 


## Example of codes

The following Tidal Cycle code switches to camera 2, from the current camera with a 1.5 second transition.
```haskell
once $ ue_camera 2  # ue_camerablendtime 1.5
```

The following Tidal Cycle code alternates cameras 1 and 2 with each cycle, which generates the synesthetic or synchronous perception with the "bd" and "cd" samples of the musical pattern, the changes of the cameras transition in 0.5 seconds.
```haskell
d1 $ sound "bd cp" # ue_camera "<1 2>" # ue_camerablendtime 0.5
```

