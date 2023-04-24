import oscP5.*;
import netP5.*;

OscP5 tidalcyclesOSC;
//NetAddress AbletonLiveOSC;
NetAddress UnrealEngineOSC;

final int receivingSocket = 1818; // from deliver hub
final int sendingSocket = 8011; // from deliver hub

void setupOsc() {
  tidalcyclesOSC = new OscP5(this, receivingSocket);
  UnrealEngineOSC = new NetAddress("127.0.0.1", sendingSocket);
}

void oscEvent(OscMessage m) {
  //println(m);
  if (m.checkAddrPattern("/delivery")==true ) {
    StringDict tidalLayer = new StringDict();
    for (int d=0; d<m.typetag().length(); d+=2 ) {
      String property = m.get(d).stringValue();
      String value = "";
      switch( m.typetag().charAt(d+1) ) {
      case 's':
        value = m.get(d+1).stringValue();
        break;
      case 'f':
        value = str(m.get(d+1).floatValue());
        break;
      case 'i':
        value = str(m.get(d+1).intValue());
        break;
      case 'b':
        //println("Binario");
        break;
      default:
        //println("None");
        break;
      }
      tidalLayer.set(property, value);
    }
    // printArray(  tidalLayer );

    /* --------------------------------------- */
    /* ----------- UNREAL ENGINE ------------- */
    /* --------------------------------------- */

    // ------------------ LOAD SCENE --------------------------------

    println( tidalLayer.keyArray() );

    //for (String property : tidalLayer.keyArray() ) {
    //  println( property );
    //String oscAddr = split(property, "ueaddr_")[1];
    //if ( oscAddr != null ) {
    //  //OscMessage ue_messageT = new OscMessage( "/"+oscAddr );
    //  //ue_messageT.add( 1 );
    //  //tidalcyclesOSC.send(ue_messageT, UnrealEngineOSC);
    //  //println( ue_messageT );
    //};
    //}

    //String oscAddr = split(men, ',');
    //OscMessage ue_messageT = new OscMessage("/hola");
    //ue_messageT.add( 1 );
    //tidalcyclesOSC.send(ue_messageT, UnrealEngineOSC);


    //if ( tidalLayer.hasKey("ue_scene") ) {
    //  OscMessage ue_message = new OscMessage("/scene");
    //  //ue_message.add( parseInt(tidalLayer.get("ue_scene") ) );
    //  ue_message.add( tidalLayer.get("ue_scene") );
    //  tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    //}

    //if ( tidalLayer.hasKey("ue_level") ) {
    //  OscMessage ue_message = new OscMessage("/level");
    //  //ue_message.add( parseInt(tidalLayer.get("ue_scene") ) );
    //  ue_message.add( tidalLayer.get("ue_level") );
    //  tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    //}


    if ( tidalLayer.hasKey("ue_camera")  ) {
      float blendtime = 0;
      if ( tidalLayer.hasKey( "ue_camerablendtime") ) blendtime = parseFloat(tidalLayer.get("ue_camerablendtime") );
      OscMessage ue_message = new OscMessage("/camera" );
      ue_message.add( parseInt(tidalLayer.get("ue_camera") ) );
      ue_message.add( blendtime );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey("ue_exposure")   ) {
      OscMessage ue_message = new OscMessage( "/exposure" );
      ue_message.add( parseFloat(tidalLayer.get("ue_exposure") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey( "ue_exposurefrom") && tidalLayer.hasKey( "ue_exposureto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/exposureramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_exposurefrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_exposureto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    // ------------------------- RGBW --------------------------------------

    if ( tidalLayer.hasKey( "ue_offsetr") && tidalLayer.hasKey( "ue_offsetg") && tidalLayer.hasKey( "ue_offsetb") && tidalLayer.hasKey( "ue_offsetw") && !tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/offsetrgbw" );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetr") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetg") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetb") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetw") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if (
      tidalLayer.hasKey( "ue_offsetr")  && tidalLayer.hasKey( "ue_offsetg")  && tidalLayer.hasKey( "ue_offsetb")  && tidalLayer.hasKey( "ue_offsetw") &&
      tidalLayer.hasKey( "ue_offsetr2") && tidalLayer.hasKey( "ue_offsetg2") && tidalLayer.hasKey( "ue_offsetb2") && tidalLayer.hasKey( "ue_offsetw2") &&
      tidalLayer.hasKey( "ue_normalizedtime")
      ) {
      OscMessage ue_message = new OscMessage("/offsetrgbwramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetr") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetg") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetb") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetw") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetr2") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetg2") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetb2") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_offsetw2") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }




    // ------------------------- RECT LIGHT ---------------------------------------
    if ( tidalLayer.hasKey("ue_rectlight") ) {
      if ( tidalLayer.hasKey( "ue_onoff") ) {
        OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/onoff" );
        ue_message.add( parseInt(tidalLayer.get("ue_onoff") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
      if ( tidalLayer.hasKey( "ue_intensity") ) {
        OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/intensity" );
        ue_message.add( parseFloat(tidalLayer.get("ue_intensity") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
      if ( tidalLayer.hasKey( "ue_intensityfrom") && tidalLayer.hasKey( "ue_intensityto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
        OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/intensityramp" );
        ue_message.add( parseFloat(tidalLayer.get("ue_intensityfrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_intensityto") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }

      if ( tidalLayer.hasKey( "ue_red") && tidalLayer.hasKey( "ue_green") && tidalLayer.hasKey( "ue_blue")   ) {
        OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/color" );
        ue_message.add( parseFloat(tidalLayer.get("ue_red") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_green") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_blue") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
        println( ue_message );
      }

      if (    tidalLayer.hasKey( "ue_redfrom") && tidalLayer.hasKey( "ue_greenfrom") && tidalLayer.hasKey( "ue_bluefrom")
        && tidalLayer.hasKey( "ue_redto") && tidalLayer.hasKey( "ue_greento") && tidalLayer.hasKey( "ue_blueto")
        && tidalLayer.hasKey( "ue_normalizedtime")
        ) {
        OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/colorramp" );
        ue_message.add( parseFloat(tidalLayer.get("ue_redfrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_greenfrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_bluefrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_redto") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_greento") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_blueto") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
        println( ue_message );
      }
      //if ( tidalLayer.hasKey( "ue_wx") && tidalLayer.hasKey( "ue_wy") && tidalLayer.hasKey( "ue_wz") && !tidalLayer.hasKey( "ue_wx2")  ) {
      //  OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/worldlocation" );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wx") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wy") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wz") ) );
      //  tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      //}
      //if ( tidalLayer.hasKey( "ue_wx") && tidalLayer.hasKey( "ue_wy") && tidalLayer.hasKey( "ue_wz") && tidalLayer.hasKey( "ue_wx2") && tidalLayer.hasKey( "ue_wy2") && tidalLayer.hasKey( "ue_wz2") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      //  OscMessage ue_message = new OscMessage("/rectlight/"+tidalLayer.get("ue_rectlight")+"/worldlocationramp" );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wx") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wy") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wz") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wx2") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wy2") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_wz2") ) );
      //  ue_message.add( parseFloat( tidalLayer.get( "ue_normalizedtime") ) );
      //  tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      //}
    }

    // ********** ue_geometry ******** //
    if ( tidalLayer.hasKey("ue_geometry") ) {
      println( parseInt( tidalLayer.get("ue_geometry") ) );
      String addrObj = "/geometry/"+tidalLayer.get("ue_geometry");
      // visible
      if ( tidalLayer.hasKey( "ue_visible") ) {
        OscMessage ue_message = new OscMessage(addrObj + "/visible" );
        ue_message.add( parseInt(tidalLayer.get("ue_visible") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
        println( ue_message );
      }
      
      // worldlocation
      if ( tidalLayer.hasKey( "ue_worldlocationx") && tidalLayer.hasKey( "ue_worldlocationy") && tidalLayer.hasKey( "ue_worldlocationz")   ) {
        OscMessage ue_message = new OscMessage(addrObj + "/worldlocation" );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationx") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationy") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationz") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
      // worldrotation
      if ( tidalLayer.hasKey( "ue_worldrotatex") && tidalLayer.hasKey( "ue_worldrotatey") && tidalLayer.hasKey( "ue_worldrotatez")   ) {
        OscMessage ue_message = new OscMessage(addrObj + "/worldrotate" );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldrotatex") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldrotatey") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldrotatez") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
      // worldscale
      if ( tidalLayer.hasKey( "ue_worldscalex") && tidalLayer.hasKey( "ue_worldscaley") && tidalLayer.hasKey( "ue_worldscalez")   ) {
        OscMessage ue_message = new OscMessage(addrObj + "/worldscale" );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldscalex") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldscaley") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldscalez") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
      // worldtranslate
      if ( tidalLayer.hasKey( "ue_worldtranslatex") && tidalLayer.hasKey( "ue_worldtranslatey") && tidalLayer.hasKey( "ue_worldtranslatez")   ) {
        OscMessage ue_message = new OscMessage(addrObj + "/worldtranslate" );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldtranslatex") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldtranslatey") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldtranslatez") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
      // worldlocation
      if ( tidalLayer.hasKey( "ue_worldlocationxfrom") && tidalLayer.hasKey( "ue_worldlocationyfrom") && tidalLayer.hasKey( "ue_worldlocationzfrom")
        && tidalLayer.hasKey( "ue_worldlocationxto") && tidalLayer.hasKey( "ue_worldlocationyto") && tidalLayer.hasKey( "ue_worldlocationzto")
        && tidalLayer.hasKey( "ue_normalizedtime")
        ) {
        OscMessage ue_message = new OscMessage(addrObj + "/worldlocationramp" );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationxfrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationyfrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationzfrom") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationxto") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationyto") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_worldlocationzto") ) );
        ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
    }

    // ---------------------- barrasrotulo (Mali) ---------------------------------

    if ( tidalLayer.hasKey( "ue_barrasrotulo") && tidalLayer.hasKey( "ue_barrasrotulotime") && tidalLayer.hasKey( "ue_barrasrotulointensidad") && tidalLayer.hasKey( "ue_barrasrotulor") && tidalLayer.hasKey( "ue_barrasrotulog") && tidalLayer.hasKey( "ue_barrasrotulob") ) {
      OscMessage ue_message = new OscMessage("/barrarotulo" );

      ue_message.add( parseInt( tidalLayer.get("ue_barrasrotulo") ) );
      ue_message.add( parseFloat( tidalLayer.get("ue_barrasrotulotime") ) );
      ue_message.add( parseFloat( tidalLayer.get("ue_barrasrotulointensidad") ) );
      ue_message.add( parseFloat( tidalLayer.get("ue_barrasrotulor") ) );
      ue_message.add( parseFloat( tidalLayer.get("ue_barrasrotulog") ) );
      ue_message.add( parseFloat( tidalLayer.get("ue_barrasrotulob") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      // println( "envio: ", ue_message );
    }


    //if ( tidalLayer.hasKey( "ue_offsettime") && tidalLayer.hasKey( "ue_offsetr") && tidalLayer.hasKey( "ue_offsetg") && tidalLayer.hasKey( "ue_offsetb") && tidalLayer.hasKey( "ue_offsety") && tidalLayer.hasKey( "ue_offsetr2") && tidalLayer.hasKey( "ue_offsetg2") && tidalLayer.hasKey( "ue_offsetb2") && tidalLayer.hasKey( "ue_offsety2") ) {
    //  OscMessage ue_message = new OscMessage("/offsetrgbylerp" );
    //  //ue_message.add( tidalLayer.get("ue_camerapos") );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsettime") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetr") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetg") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetb") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsety") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetr2") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetg2") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetb2") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsety2") ) );
    //  tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    //} else if ( tidalLayer.hasKey( "ue_offsetr") && tidalLayer.hasKey( "ue_offsetg") && tidalLayer.hasKey( "ue_offsetb") && tidalLayer.hasKey( "ue_offsety") ) {
    //  OscMessage ue_message = new OscMessage("/offsetrgby" );
    //  //ue_message.add( tidalLayer.get("ue_camerapos") );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetr") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetg") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsetb") ) );
    //  ue_message.add( parseFloat( tidalLayer.get("ue_offsety") ) );
    //  tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    //}

    //--------------------- Post FX --------------------------------

    if ( tidalLayer.hasKey( "ue_bwlineartfxapply") && tidalLayer.hasKey( "ue_bwlineartfxlinedeph") && tidalLayer.hasKey( "ue_bwlineartfxpower") ) {
      OscMessage ue_message = new OscMessage("/bwlineartfx" );
      ue_message.add( parseFloat(tidalLayer.get("ue_bwlineartfxapply") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_bwlineartfxlinedeph") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_bwlineartfxpower") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey( "ue_pixelstylefxapply") && tidalLayer.hasKey( "ue_pixelstylefxgridres") ) {
      OscMessage ue_message = new OscMessage("/pixelstylefx" );
      ue_message.add( parseFloat(tidalLayer.get("ue_pixelstylefxapply") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_pixelstylefxgridres") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey( "ue_asciifxapply") && tidalLayer.hasKey( "ue_asciifxpixelation") ) {
      OscMessage ue_message = new OscMessage("/asciifx" );
      ue_message.add( parseFloat(tidalLayer.get("ue_asciifxapply") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_asciifxpixelation") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey( "ue_dispmapfxapply") && tidalLayer.hasKey( "ue_dispmapfxx") && tidalLayer.hasKey( "ue_dispmapfxx") && tidalLayer.hasKey( "ue_dispmapfxreactiveaudio") ) {
      OscMessage ue_message = new OscMessage("/dispmapfx" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispmapfxapply") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispmapfxx") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispmapfxy") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispmapfxreactiveaudio") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    // ------------------------- VOT (Value Over Time ) ------------------------------

    if ( tidalLayer.hasKey( "ue_vot") ) {
      if ( parseInt( tidalLayer.get("ue_vot") ) == 1 ) {
        OscMessage ue_message = new OscMessage("/vot" );
        String votcode = "";
        for (String k : tidalLayer.keys()) {
          votcode += k + ": " + tidalLayer.get(k) + ", ";
        }
        ue_message.add( votcode );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      } else {
        OscMessage ue_message = new OscMessage("/emptyvot" );
        ue_message.add( 0 );
        tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      }
    }

    if ( tidalLayer.hasKey( "ue_votr") && tidalLayer.hasKey( "ue_votg") && tidalLayer.hasKey( "ue_votb") && tidalLayer.hasKey( "ue_vota")  ) {
      OscMessage ue_message = new OscMessage("/votrgba" );
      ue_message.add( parseFloat(tidalLayer.get("ue_votr") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_votg") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_votb") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_vota") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey( "ue_votfontsize") ) {
      OscMessage ue_message = new OscMessage("/votfontsize" );
      ue_message.add( parseInt(tidalLayer.get("ue_votfontsize") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }


    // -------------------------- TEMP -----------------------------------

    if ( tidalLayer.hasKey( "ue_temp") ) {
      OscMessage ue_message = new OscMessage("/temp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_temp") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    if ( tidalLayer.hasKey( "ue_tempfrom") && tidalLayer.hasKey( "ue_tempto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/tempramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_tempfrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_tempto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      // }
    }

    // -------------------------- DISP ------------------------------------
    if ( tidalLayer.hasKey( "ue_dispx") ) {
      OscMessage ue_message = new OscMessage("/dispx" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispx") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }
    if ( tidalLayer.hasKey( "ue_dispy") ) {
      OscMessage ue_message = new OscMessage("/dispy" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispy") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }
    if ( tidalLayer.hasKey( "ue_dispxfrom") && tidalLayer.hasKey( "ue_dispxto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/dispxramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispxfrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispxto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }
    if ( tidalLayer.hasKey( "ue_dispyfrom") && tidalLayer.hasKey( "ue_dispyto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/dispyramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispyfrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispyto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    // ------------------------ DISP SPEED ----------------------------------
    if ( tidalLayer.hasKey( "ue_dispxspeed") ) {
      OscMessage ue_message = new OscMessage("/dispxspeed" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispxspeed") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }
    if ( tidalLayer.hasKey( "ue_dispyspeed") ) {
      OscMessage ue_message = new OscMessage("/dispyspeed" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispyspeed") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }
    if ( tidalLayer.hasKey( "ue_dispxspeedfrom") && tidalLayer.hasKey( "ue_dispxspeedto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/dispxspeedramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispxspeedfrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispxspeedto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }
    if ( tidalLayer.hasKey( "ue_dispyspeedfrom") && tidalLayer.hasKey( "ue_dispyspeedto") && tidalLayer.hasKey( "ue_normalizedtime") ) {
      OscMessage ue_message = new OscMessage("/dispyspeedramp" );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispyspeedfrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_dispyspeedto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_normalizedtime") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    // ---------------------- disptexturesample -------------------------------

    if ( tidalLayer.hasKey( "ue_disptexturesample") ) {
      OscMessage ue_message = new OscMessage("/disptexturesample" );
      ue_message.add( tidalLayer.get("ue_disptexturesample")  );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }

    // --------------------------------- SUN TIME ----------------------------------

    if ( tidalLayer.hasKey("ue_suntime") && tidalLayer.hasKey("ue_horanglefrom") && tidalLayer.hasKey( "ue_horangleto") && tidalLayer.hasKey( "ue_veranglefrom") && tidalLayer.hasKey( "ue_verangleto") ) {
      OscMessage ue_message = new OscMessage("/sun" );
      ue_message.add( parseFloat(tidalLayer.get("ue_suntime") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_horanglefrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_horangleto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_veranglefrom") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_verangleto") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
    }


    // -------------------------------- OBJECT FAMILY -------------------------------
    if ( tidalLayer.hasKey("ue_familiaobjetos") &&  tidalLayer.hasKey("ue_indexobjeto") && tidalLayer.hasKey("ue_intensity") ) {
      OscMessage ue_message = new OscMessage( "/"+tidalLayer.get("ue_familiaobjetos") );
      ue_message.add( parseFloat(tidalLayer.get("ue_indexobjeto") ) );
      ue_message.add( parseFloat(tidalLayer.get("ue_intensity") ) );
      tidalcyclesOSC.send(ue_message, UnrealEngineOSC);
      println( ue_message);
    }
  }
}
