![LIVE CINEMA CODING | AUTOCONSTRUCCION | ICLC 2023](https://livecinemacoding.xyz/images/livecinemacoding-iclc2023-01.jpg "LIVE CINEMA CODING | AUTOCONSTRUCCION | ICLC 2023")
###### Audiovisual concert controlling Unreal Engine from Tidal Cycles | ICLC 2023, Utrecht, The Netherlands

<dl>
<br>
</dl>

##### *ICLC 2023*
# Live Cinema Coding 
### Using **Tidal Cycles**, **Processing** and **Unreal Engine**
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

[![SC2 Video](https://livecinemacoding.xyz/images/workshop-livecinemacoding-cameras-play.jpg)](https://livecinemacoding.xyz/videos/workshop-livecinemacoding-cameras.mp4 "Click to play >") 


### CAMERAS -- CODE EXAMPLES

The following Tidal Cycle code switches to camera 2, from the current camera with a 1.5 second transition.
```haskell
once $ ue_camera 2  # ue_camerablendtime 1.5
```

The following Tidal Cycle code alternates cameras 1 and 2 with each cycle, which generates the synesthetic or synchronous perception with the "bd" and "cd" samples of the musical pattern, the changes of the cameras transition in 0.5 seconds.
```haskell
d1 $ sound "bd cp" # ue_camera "<1 2>" # ue_camerablendtime 0.5
```

OFFSETRGBW DEMO (from scratch):

[![SC2 Video](https://livecinemacoding.xyz/images/workshop-livecinemacoding-offsetrgbw-play.jpg)](https://livecinemacoding.xyz/videos/workshop-livecinemacoding-offsetrgbw.mp4 "Click to play >") 

### OFFSETRGBW -- CODE EXAMPLES

The range of each parameter **R G B W** is between **-1** and **1**, where **1** tends to white and **-1** to black. Negative values need to be enclosed in quotes "-0.5" or in parentheses (-0.5)

The following Tidal Cycle code shifts red to a value of 1, leaving green, blue, and white balance at zero values.

```haskell
once $ ue_offsetrgbw 1 0 0 0
```

The following Tidal Cycle code creates a ramp between two sets of RGBW colors with a 2 second transition, the first set of RGBW parameters is (-0.25) 1 1 0.5 and the second 0 0 0 0 (which are the default values)

```haskell
once $ ue_offsetrgbwramp (-0.25) 1     1     0.5
                         0       0     0     0
                         2

-- once $ ue_offsetrgbwramp R G B W (from)
--                          R G B W (to)
--                          2 (seconds)
```

EXPOSURE DEMO (from scratch):

[![SC2 Video](https://livecinemacoding.xyz/images/workshop-livecinemacoding-exposure-play.jpg)](https://livecinemacoding.xyz/videos/workshop-livecinemacoding-exposure.mp4 "Click to play >") 

### EXPOSURE -- CODE EXAMPLES


