package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.TextView;

import org.w3c.dom.Text;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.SortedMap;

public class AfterGameActivity extends AppCompatActivity {

    private LinearLayout MesResultatsDeJoueurs;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_after_game);
        String LePlusGrosAlcolo = "Le/la plus gros(se) alcoolo, ";

        MesResultatsDeJoueurs = findViewById(R.id.LayoutResultats);

        HashMap<String, Integer> MesjoueursATrier = new HashMap<String, Integer>();

        ArrayList<String> mesJoueursPourLactivity = getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();

        StringBuilder sb = new StringBuilder();
//Pour la distribution on divisera par 5 je pense
        for (int i = 0; i < mesJoueursPourLactivity.size(); i++) {
            TextView ResMonJoueur = new TextView(AfterGameActivity.this);

            sb.append(mesJoueursPourLactivity.get(i));
            sb.append(" ");
            sb.append(mesJoueurs.getInt(mesJoueursPourLactivity.get(i), 0));
            ResMonJoueur.setText(sb.toString());
            MesjoueursATrier.put(mesJoueursPourLactivity.get(i), mesJoueurs.getInt(mesJoueursPourLactivity.get(i), 0))
            sb.setLength(0);
        }
        List<Map.Entry<String, Integer>> list = new LinkedList<Map.Entry<String, Integer>>(MesjoueursATrier.entrySet());
        Collections.sort(list, new Comparator<Entry<String, Integer>>() {
            @Override
            public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2) {
                return (o1.getValue()).compareTo(o2.getValue());
            }
        });

        HashMap<String, Integer> temp = new LinkedHashMap<String, Integer>();
        for (Map.Entry<String, Integer> aa : list) {
            temp.put(aa.getKey(), aa.getValue());

        }


        for(int i=0;i<MesjoueursATrier.size();i++){

        }
    }
}