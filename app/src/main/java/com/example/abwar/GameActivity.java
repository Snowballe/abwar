package com.example.abwar;

import androidx.annotation.ColorInt;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
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
    private LinearLayout ScoreboardJoueurs;
    private View viewGameBackground;
    private ImageView imageViewlogo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);


        ArrayList<String> BackgroundColors = new ArrayList<>();

        BackgroundColors.add("#E9CE2C");
        BackgroundColors.add("#E88986");
        BackgroundColors.add("#00CC83");
        BackgroundColors.add("#55868C");
        BackgroundColors.add("#022B3A");

        ArrayList<String> mesJoueursPourLactivity = getIntent().getStringArrayListExtra("ACCES_JOUEURS");

        imageViewlogo = findViewById(R.id.imageViewlogo);
        viewGameBackground = findViewById(R.id.viewGameBackground);
        ScoreboardJoueurs = findViewById(R.id.emplacementJoueurs);
        textViewQuestion = findViewById(R.id.textViewQuestion);
        BtnNext = findViewById(R.id.BtnNext);

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
        viewGameBackground.setBackgroundColor(Color.parseColor("#000000"));
        textViewQuestion.setText("Est-ce que tout le monde est prêt ?");

        for (int i = 0; i < mesJoueursPourLactivity.size(); i++) {
            LinearLayout layoutJoueur = new LinearLayout(GameActivity.this);
            layoutJoueur.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
            layoutJoueur.setOrientation(LinearLayout.VERTICAL);

            final int[] scoreBoisson = {0};
            if (layoutJoueur.getParent() != null) {
                ((ViewGroup) layoutJoueur.getParent()).removeView(layoutJoueur);

            }
            ScoreboardJoueurs.addView(layoutJoueur);

            LinearLayout layoutBoutons = new LinearLayout(GameActivity.this);
            layoutJoueur.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT));
            layoutJoueur.setOrientation(LinearLayout.HORIZONTAL);


            if (layoutBoutons.getParent() != null) {
                ((ViewGroup) layoutBoutons.getParent()).removeView(layoutJoueur);
            }


            StringBuilder sb = new StringBuilder();
            sb.append(mesJoueursPourLactivity.get(i));
            sb.append(" : 0");

            int index = i;

            TextView NomJoueur = new TextView(GameActivity.this);
            NomJoueur.setText(sb.toString());

            Button BtnPlus = new Button(GameActivity.this);
            BtnPlus.setLayoutParams(new LinearLayout.LayoutParams(120, ViewGroup.LayoutParams.WRAP_CONTENT));

            BtnPlus.setText("+");
            BtnPlus.setId(new Random().nextInt());

            Button BtnMoins = new Button(GameActivity.this);
            BtnMoins.setLayoutParams(new LinearLayout.LayoutParams(120, ViewGroup.LayoutParams.WRAP_CONTENT));
            BtnMoins.setText("-");

            if (NomJoueur.getParent() != null || BtnPlus.getParent() != null || BtnMoins.getParent() != null) {
                ((ViewGroup) NomJoueur.getParent()).removeView(NomJoueur);
                ((ViewGroup) BtnPlus.getParent()).removeView(BtnPlus);
                ((ViewGroup) BtnMoins.getParent()).removeView(BtnMoins);
            }

            layoutJoueur.addView(NomJoueur);
            ScoreboardJoueurs.addView(layoutBoutons);

            layoutBoutons.addView(BtnPlus);
            layoutBoutons.addView(BtnMoins);

            BtnPlus.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    sb.deleteCharAt(sb.length() - 1);
                    sb.deleteCharAt(sb.length() - 1);
                    sb.deleteCharAt(sb.length() - 1);

                    scoreBoisson[0]++;

                    sb.append(Arrays.toString(scoreBoisson));
                    String MonNouveauScore = sb.toString();
                    MonNouveauScore = MonNouveauScore.replace("[", "");
                    MonNouveauScore = MonNouveauScore.replace("]", "");

                    NomJoueur.setText(MonNouveauScore);

                    if (NomJoueur.getParent() != null) {
                        ((ViewGroup) NomJoueur.getParent()).removeView(NomJoueur);
                    }

                    layoutJoueur.addView(NomJoueur);
                    editor.putInt(mesJoueursPourLactivity.get(index), scoreBoisson[0]);
                    editor.commit();
                }
            });

            BtnMoins.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (scoreBoisson[0] != 0) {
                        sb.deleteCharAt(sb.length() - 1);
                        sb.deleteCharAt(sb.length() - 1);
                        sb.deleteCharAt(sb.length() - 1);

                        scoreBoisson[0]--;

                        sb.append(Arrays.toString(scoreBoisson));
                        String MonNouveauScore = sb.toString();
                        MonNouveauScore = MonNouveauScore.replace("[", "");
                        MonNouveauScore = MonNouveauScore.replace("]", "");
                        NomJoueur.setText(MonNouveauScore);
                        if (NomJoueur.getParent() != null) {
                            ((ViewGroup) NomJoueur.getParent()).removeView(NomJoueur);
                        }
                        layoutJoueur.addView(NomJoueur);
                        editor.putInt(mesJoueursPourLactivity.get(index), scoreBoisson[0]);
                        editor.commit();

                    }

                }
            });
        }

        BtnNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //region Backend

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
                ArrayList<String> ArraySplittedavantverifQuestionJoueurs = new ArrayList<String>(Arrays.asList(MaQuestion.split("%plr")));

                while (ArraySplittedavantverifQuestionJoueurs.size() > mesJoueursPourLactivity.size()) {
                    MaQuestion = ConvertedQuestions.get(randomIndexQuestion);
                }

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
                    GotoAfterGameActivity.putExtra("ACCES_JOUEURS", mesJoueursPourLactivity);
                    startActivity(GotoAfterGameActivity);
                }

                //endregion

                //region Frontend
                int randomBackgroundColor = new Random().nextInt(BackgroundColors.size());
                if (BackgroundColors.get(randomBackgroundColor) == "#E9CE2C") {
                    textViewQuestion.setTextColor(Color.parseColor("#000000"));
                    imageViewlogo.setImageResource(R.drawable.abwarnoirtransparet);
                } else {
                    textViewQuestion.setTextColor(Color.parseColor("#FFFFFF"));
                    imageViewlogo.setImageResource(R.drawable.abwarblanctransparet);

                }
                viewGameBackground.setBackgroundColor(Color.parseColor(BackgroundColors.get(randomBackgroundColor)));

                BtnNext.setTextColor(Color.parseColor(BackgroundColors.get(randomBackgroundColor)));
                //endregion
            }
        });
    }
    }



