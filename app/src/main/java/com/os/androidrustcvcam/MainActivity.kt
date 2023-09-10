package com.os.androidrustcvcam

import android.graphics.Bitmap
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
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
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.core.graphics.drawable.toBitmap
import coil.compose.AsyncImagePainter
import coil.compose.rememberAsyncImagePainter
import coil.request.ImageRequest
import com.os.androidrustcvcam.ui.theme.AndroidRustTemplateTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidRustTemplateTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background
                ) {
                    OpenCVCompose(opencvVersion());
                }
            }
        }
    }

    companion object {init {
        System.loadLibrary("rustlib")
    }
    }
}

private external fun opencvVersion(): String

@Composable
fun OpenCVCompose(ver: String, modifier: Modifier = Modifier) {

    Column(
        modifier = Modifier
            .padding(30.dp)
            .fillMaxWidth()
            .wrapContentSize(Alignment.Center)
    ) {
        Text(
            text = "OpenCV Version: $ver", modifier = modifier
        )
        DisplayBmp()
    }
}


@Composable
fun DisplayBmp(modifier: Modifier = Modifier) {

    var originalBmp = Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888)
    var modifiedBmpCv = Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888)
    val baseImage =
        "https://images.unsplash.com/photo-1628373383885-4be0bc0172fa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1301&q=80"
    val basePainter = rememberAsyncImagePainter(
        model = ImageRequest.Builder(LocalContext.current).data(baseImage)
            .size(coil.size.Size.ORIGINAL) // Set the target size to load the image at.
            .build()
    )

    val baseImageLoadedState = basePainter.state
    if (baseImageLoadedState is AsyncImagePainter.State.Success) originalBmp =
        baseImageLoadedState.result.drawable.toBitmap()


    Column(
        modifier = Modifier
            .padding(20.dp)
            .fillMaxWidth()
            .wrapContentSize(Alignment.Center)

    ) {

        // Display bitmap image
        Image(
            painter = rememberAsyncImagePainter(originalBmp),
            contentDescription = "Image",
            modifier = Modifier
                .fillMaxHeight()
                .weight(1f)
                .clip(MaterialTheme.shapes.medium),
            contentScale = ContentScale.Crop
        )
        Image(
            painter = rememberAsyncImagePainter(originalBmp),
            contentDescription = "Image",
            modifier = Modifier
                .fillMaxHeight()
                .weight(1f)
                .clip(MaterialTheme.shapes.medium),
            contentScale = ContentScale.Crop
        )

    }

}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AndroidRustTemplateTheme {
        OpenCVCompose("OpenCV Version")
    }
}
