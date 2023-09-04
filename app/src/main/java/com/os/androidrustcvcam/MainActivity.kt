package com.os.androidrustcvcam

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.os.androidrustcvcam.ui.theme.AndroidRustTemplateTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidRustTemplateTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    OpencvVersion(opencvVersion())
                }
            }
        }
    }

    companion object {
        init {
            System.loadLibrary("rustlib")
        }
    }

}

private external fun opencvVersion(): String

@Composable
fun OpencvVersion(ver: String, modifier: Modifier = Modifier) {
    Column(
        modifier = Modifier
            .padding(30.dp)
            .fillMaxWidth()
            .wrapContentSize(Alignment.Center)
    ) {

        Text(
            text = "OpenCV Version: $ver",
            modifier = modifier

        )
    }

}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AndroidRustTemplateTheme {
        OpencvVersion("OpenCV Version")
    }
}
