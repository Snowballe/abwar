package com.moski.testapp

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.widget.ConstraintLayout
import kotlin.random.Random

class Question_rtn {
    var plr_list :  Array<Buveur> = emptyArray()
    var question_list  :  Array<String> = emptyArray()
}

fun background_color_change(constraintLayout: ConstraintLayout) {
    val allcolor : Array<Int> =  arrayOf(0xef476f, 0xfd166, 0x06d6a0, 0x118ab2)
    constraintLayout.setBackgroundColor(allcolor.random())
}

fun remove_b(arr: Array<Buveur>, index: Int): Array<Buveur> {
    if (index < 0 || index >= arr.size) {
        return arr
    }

    val result = arr.toMutableList()
    result.removeAt(index)
    return result.toTypedArray()
}

fun remove_s(arr: Array<String>, index: Int): Array<String> {
    if (index < 0 || index >= arr.size) {
        return arr
    }

    val result = arr.toMutableList()
    result.removeAt(index)
    return result.toTypedArray()
}


class Main2Activity : AppCompatActivity() {

    //Declaration de mon bouton
    lateinit var Next_Question : Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main2)

        //initialisation
        Next_Question = findViewById(R.id.NextQuestion)

        var question_list =  resources.getStringArray(R.array.Questions)
        //val question_list = arrayOf<String>("Trouvez chacun votre nom d'acteur porno, le meilleur nom gagne un dessert ?","%plr  Prends une feuille et un stylo, il doit dessiner quelqu'un ici et si %plr arrive à deviner, l'artiste peut distribuer %gog gorgées, sinon il les boit")

        val intent = intent
        var player_list: Array<Buveur> = intent.getSerializableExtra("player") as Array<Buveur>
        var Question_Text = findViewById<TextView>( R.id.QuestionView)
        var temp_plr_list = player_list
        var tmp_question_list = question_list

        New_Question(Question_Text, player_list, question_list, player_list.size)

        Next_Question.setOnClickListener{
            if(temp_plr_list.size < 3) temp_plr_list = player_list
            val qstn_rtn = New_Question(Question_Text, temp_plr_list, question_list, player_list.size)
            temp_plr_list = qstn_rtn.plr_list
            question_list =  qstn_rtn.question_list

        }


    }


    private fun New_Question(TextViewer: TextView, Player_List: Array<Buveur>, line_list: Array<String>, Nb_Plr: Int): Question_rtn{
        val rnds = (0..line_list.size-1).random()
        var tmp_plr_list = Player_List
        var question = line_list[rnds]
        var qstn = Question_rtn()
        qstn.question_list = remove_s(line_list, rnds)

        while (question.indexOf("%plr") != -1)
        {
            val tag_index = question.indexOf("%plr")
            val rnd_plr_index = (0..tmp_plr_list.size-1).random()
            question = question.substring(0,tag_index) + tmp_plr_list[rnd_plr_index].name + question.substring(tag_index+4)
            tmp_plr_list = remove_b( tmp_plr_list, rnd_plr_index)
        }

        while (question.indexOf("%tot") != -1)
        {
            val tag_index = question.indexOf("%tot")
            question = question.substring(0,tag_index) + Nb_Plr.toString()  + question.substring(tag_index+4)
        }

        while (question.indexOf("%gog") != -1)
        {
            val tag_index = question.indexOf("%gog")
            question = question.substring(0,tag_index) + (1..10).random().toString() + question.substring(tag_index+4)
        }

        qstn.plr_list = tmp_plr_list

        TextViewer.text = question
        return qstn
    }
}