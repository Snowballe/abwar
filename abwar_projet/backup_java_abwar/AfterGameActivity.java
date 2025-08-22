package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.EmojiCompatConfigurationView;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.util.Pair;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class AfterGameActivity extends AppCompatActivity {

    private LinearLayout MesResultatsDeJoueurs;
    private Button BtnToAccueil;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_after_game);
        String LePlusGrosAlcolo = "Le/la plus gros(se) alcoolo, ";
        BtnToAccueil = findViewById(R.id.buttonToAcceuil);
        MesResultatsDeJoueurs = findViewById(R.id.LayoutResultats);


        ArrayList<String> mesJoueursPourLactivity = getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();

        StringBuilder sb = new StringBuilder();


        //fill une nouvelle hashmap avec les gorgées correspondantes
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        for (int i=0;i<mesJoueursPourLactivity.size();i++){
            int moncul = mesJoueurs.getInt(mesJoueursPourLactivity.get(i),0);
            hm.put(mesJoueursPourLactivity.get(i),moncul);
        }

        List<Map.Entry<String, Integer> > list =
                new LinkedList<Map.Entry<String, Integer> >(hm.entrySet());

        // Sort the list
        Collections.sort(list, new Comparator<Map.Entry<String, Integer> >() {
            public int compare(Map.Entry<String, Integer> o1,
                               Map.Entry<String, Integer> o2)
            {
                return (o1.getValue()).compareTo(o2.getValue());
            }
        });

        //et la sort




        //Pour la distribution on divisera par 5 je pense
        for (int i=list.size()-1;i>=0;i--) {

            //region top 3
            if(i==list.size()-1){
                sb.append(Character.toChars(0x1F3C6));//emoji 🏆 trophée
            }else if(i==list.size()-2){
                sb.append(Character.toChars(0x1F3C5));// emoji 🏅 médaille
            }else if(i==list.size()-3){
                sb.append(Character.toChars(0x1F37A)); // emoji 🍺 biere
            }
            // Malheureusment obligé de faire des else if parce que la switch case aime pas les list.size, vu que c'est du dynamique
            //endregion




            TextView ResMonJoueur = new TextView(AfterGameActivity.this);
            ResMonJoueur.setTextColor(Color.parseColor("#000000"));
            ResMonJoueur.setTextSize(20);

            sb.append(list.get(i).getKey());

            sb.append(" : ");
            sb.append(list.get(i).getValue());
            sb.append(" gorgées bues, tu pourras distribuer ");
            sb.append(list.get(i).getValue() / 5);
            sb.append("\n");
            ResMonJoueur.setText(sb.toString());
            MesResultatsDeJoueurs.addView(ResMonJoueur);


            sb.setLength(0);


        }

        BtnToAccueil.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                editor.clear();
                editor.commit();
                Intent GotoAccueilActivity = new Intent(AfterGameActivity.this, AccueilActivity.class);
                startActivity(GotoAccueilActivity);
            }
        });

    }

}



