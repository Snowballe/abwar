package com.example.abwar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.ArrayList;
import java.util.Random;

public class GameActivity extends AppCompatActivity {
    private DBHandler dbHandler;
private TextView textViewQuestion;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        dbHandler=new DBHandler(GameActivity.this);
        textViewQuestion=findViewById(R.id.textViewQuestion);

        ArrayList<String> mesJoueursPourLactivity=getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        int MaxInt=getIntent().getIntExtra("MaxRandInt",0);
        int MinInt=getIntent().getIntExtra("MinRandInt",0);

        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();
        try {
            InputStream is=GameActivity.this.getResources().getAssets().open("questions.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            LineNumberReader lnr=new LineNumberReader(reader);
            Random r = new Random();
            int n =r.nextInt(124);
            lnr.setLineNumber(n);
            String maQuestion=lnr.readLine();
            textViewQuestion.append(maQuestion);



        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}