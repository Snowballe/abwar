package com.example.abwar;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.IntStream;

public class GameActivity extends AppCompatActivity {
    private TextView textViewQuestion;
    private String[] RawQuestions;
    private List<String> ConvertedQuestions;
    private Button BtnNext;
    private int cptQuestions;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        textViewQuestion = findViewById(R.id.textViewQuestion);
        BtnNext = findViewById(R.id.BtnNext);

        ArrayList<String> mesJoueursPourLactivity = getIntent().getStringArrayListExtra("ACCES_JOUEURS");
        int MaxInt = getIntent().getIntExtra("MaxRandInt", 0);
        int MinInt = getIntent().getIntExtra("MinRandInt", 0);

        cptQuestions = 0;

        ArrayList<Integer> BannedIndexes = new ArrayList<>();
        ArrayList<Integer>TempbannedPlr=new ArrayList<Integer>();

        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();

        RawQuestions = getResources().getStringArray(R.array.Questions);
        ConvertedQuestions = Arrays.asList(RawQuestions);

        //Init quand c'est la 1ere fois qu'on arrive sur la page
        int randomIndex = new Random().nextInt(ConvertedQuestions.size());
        textViewQuestion.setText(RawQuestions[randomIndex]);


        BtnNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //region Init
                textViewQuestion.setText("");
                String MaQuestion=new String();

                int randomIndexJoueur= new Random().nextInt(mesJoueursPourLactivity.size());

                TempbannedPlr.add(randomIndexJoueur);

                int randomNbGorgee=new Random().nextInt(MaxInt-MinInt)+MinInt;
                int randomIndexQuestion = new Random().nextInt(ConvertedQuestions.size());
                //endregion

                while (BannedIndexes.contains(randomIndexQuestion)) {//On regarde si la question est déjà passée, on veut pas l'avoir 2 fois
                    randomIndexQuestion = new Random().nextInt(ConvertedQuestions.size());
                }
                MaQuestion=ConvertedQuestions.get(randomIndexQuestion);

                MaQuestion=MaQuestion.replace("%gog",Integer.toString(randomNbGorgee));

                Pattern patternPlr=Pattern.compile("%plr");
                Matcher matcher = patternPlr.matcher(MaQuestion);

                randomIndexJoueur = new Random().nextInt(mesJoueursPourLactivity.size());

                //Si y'a plusieurs joueurs

                while (matcher.find()){
                    while (TempbannedPlr.contains(randomIndexQuestion)) {
                        randomIndexJoueur = new Random().nextInt(mesJoueursPourLactivity.size());
                    }
                    MaQuestion=MaQuestion.replace("%plr",mesJoueursPourLactivity.get(randomIndexJoueur));
                }

                textViewQuestion.setText(MaQuestion);

                //region reset
                BannedIndexes.add(randomIndexQuestion);
                TempbannedPlr.clear();
                //endregion

                cptQuestions++;
                if (cptQuestions == 50) {//En gros la fin du jeu, on fait 50 questions
                    BannedIndexes.clear();
                    Intent GotoAfterGameActivity=new Intent(GameActivity.this, AfterGameActivity.class);
                    startActivity(GotoAfterGameActivity);
                }
            }
        });
    }
}