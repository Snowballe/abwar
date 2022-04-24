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
        ArrayList<Integer> TempbannedPlr = new ArrayList<Integer>();

        SharedPreferences mesJoueurs = getSharedPreferences("MesJoueurs", 0);
        SharedPreferences.Editor editor = mesJoueurs.edit();

        RawQuestions = getResources().getStringArray(R.array.Questions);
        ConvertedQuestions = Arrays.asList(RawQuestions);

        //Init quand c'est la 1ere fois qu'on arrive sur la page
        textViewQuestion.setText("Init de merde que je vais faire");


        BtnNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //region Init
                textViewQuestion.setText("");
                String MaQuestion = new String();

                int randomIndexJoueur = new Random().nextInt(mesJoueursPourLactivity.size());
                int randomNbGorgee = new Random().nextInt(MaxInt - MinInt) + MinInt;
                int randomIndexQuestion = new Random().nextInt(ConvertedQuestions.size());
                //endregion

                //region Evitement des répétitions de questions
                while (BannedIndexes.contains(randomIndexQuestion)) {//On regarde si la question est déjà passée, on veut pas l'avoir 2 fois
                    randomIndexQuestion = new Random().nextInt(ConvertedQuestions.size());
                }
                //endregion

                MaQuestion = ConvertedQuestions.get(randomIndexQuestion);//On se chope notre question au hasard

                StringBuilder maCouillasse = new StringBuilder();//Pour reconstruire plus tard la question, car on veut ajouter les nom des joueurs et les gorgées

                //region Formattage de la question

                //On formatte le string et on le split au niveau du tag, comme ça on aura au lieu de "%plr fait ...." on aura ["","fait ...."]
                ArrayList<String> ArraySplittedQuestionJoueurs = new ArrayList<String>(Arrays.asList(MaQuestion.split("%plr")));

                for (int i = 0; i < ArraySplittedQuestionJoueurs.size() - 1; i++) {
                    //Ici je mets size -1 pour éviter de rajouter un nom en fin du string (sinon on aurait un dylan en fin de question qui n'a rien à faire là)

                    String s = ArraySplittedQuestionJoueurs.get(i);
                    s = s + mesJoueursPourLactivity.get(randomIndexJoueur);//On ajoute notre nom désigné du coup
                    ArraySplittedQuestionJoueurs.set(i, s);
                    //et on viens remplacer le string dans notre array (obligé parce que la dernière partie de ma question est toujours dedans)

                    //ici on veut éviter les doublons, genre si ça inclus 2 joueurs ou plus
                    //Je les ajoutes dans une liste qui sera clear à la prochaine question dans tous les cas
                    TempbannedPlr.add(randomIndexJoueur);
                    do {
                        randomIndexJoueur = new Random().nextInt(mesJoueursPourLactivity.size());//On veut forcément pick qq d'autre, ne serait-ce que pour le random
                    } while (TempbannedPlr.contains(randomIndexJoueur));

                    maCouillasse.append(ArraySplittedQuestionJoueurs.get(i));
                    //On reconstruit le string avec notre builder pour avoir un joli string tout beau contenant encore les tags de gorgées
                }
                maCouillasse.append(ArraySplittedQuestionJoueurs.get(ArraySplittedQuestionJoueurs.size() - 1));

                MaQuestion = maCouillasse.toString();
                maCouillasse.setLength(0);
                // On n'oublie pas de clear le StringBuilder (ça m'avait mis les questions en doublons sinon, genre la 1ère avec les tags joueurs de résolus,
                // l'autre avec les tags gorgées, mais pas les 2 en même temps.


                ArrayList<String> ArraySplittedQuestionGorgees = new ArrayList<String>(Arrays.asList(MaQuestion.split("%gog")));

                for (int i = 0; i < ArraySplittedQuestionGorgees.size() - 1; i++) {

                    String s = ArraySplittedQuestionGorgees.get(i);
                    s = s.concat(String.valueOf(randomNbGorgee));
                    System.out.println();
                    ArraySplittedQuestionGorgees.set(i, s);
                    maCouillasse.append(ArraySplittedQuestionGorgees.get(i));
                }
                maCouillasse.append(ArraySplittedQuestionGorgees.get(ArraySplittedQuestionGorgees.size() - 1));

                MaQuestion = maCouillasse.toString();
//endregion

                //Display de la question
                textViewQuestion.setText(MaQuestion);

                //region reset
                BannedIndexes.add(randomIndexQuestion);
                TempbannedPlr.clear();
                //endregion

                cptQuestions++;
                if (cptQuestions == 50) {//todo En gros la fin du jeu, on fait 50 questions, ((((à débattre avec les autres du coup ))))
                    BannedIndexes.clear();
                    Intent GotoAfterGameActivity = new Intent(GameActivity.this, AfterGameActivity.class);
                    startActivity(GotoAfterGameActivity);
                }
            }
        });
    }
}