### Java JNI (ViSP Java binding)
- documentation:
  - [Chapter 3: JNI Types and Data Structures](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/types.html)
  - [Chapter 4: JNI Functions](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/functions.html)
  - [Java Native Methods, Alligator Descartes](http://www-igm.univ-mlv.fr/~dr/XPOSE2001/JNI/ressources/JNM_full.pdf)
  - [Java Native Interface, Ken Slonneger](http://homepage.divms.uiowa.edu/~slonnegr/wpj/JNI.pdf)
  - [The Java™ Native Interface - Programmer’s Guide and Specification](https://www.fer.unizg.hr/_download/repository/jni.pdf)
  - [Java Native Interface (JNI)](https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaNativeInterface.html)
- some possible interesting docs:
  - [JNI – C++ integration made easy, Evgeniy Gabrilovich, Lev Finkelstein](http://gabrilovich.com/publications/papers/cppr_jni.pdf)
  - [How to return a vector<Point> from a jni C++ function?](https://stackoverflow.com/questions/54398778/how-to-return-a-vectorpoint-from-a-jni-c-function/54399400#54399400)
  - [Wrapping a C++ library with JNI, part 4](https://thebreakfastpost.com/2012/03/06/wrapping-a-c-library-with-jni-part-4/)
  - [JNI (Java Native Interface)](https://www.jmdoudoux.fr/java/dej/chap-jni.htm)
- used references:
  - [[JNI] Retourner un tableau de String via JNI](https://www.developpez.net/forums/d183675/java/general-java/apis/jni-retourner-tableau-string-via-jni/#post1182317)
  <details><summary>code</summary>
  <p>

  ```
  JNIEXPORT jdoubleArray JNICALL Java_GetPosition (JNIEnv * env, jobject obj){ 
      int Vector64_Length = 3;
      jdoubleArray jPosition = NULL; //Tabla que almacena las posiciones Java type
      jdouble *Pos;	//Vector position
      C_Vectors64 *position;	//Vector Position C++ type
      C_Trajectory_Segment s = C_Trajectory_Segment(7);//Final

      position = Get_Position (s);

      if (Tratar_Excepcion() == -1) { 
        jclass newExceptionCls = env->FindClass("java/lang/IllegalArgumentException");
        env->ThrowNew(newExceptionCls, String_Excepcion);
        delete[](position);
        return jPosition;
      }
      else {
        Status_IO_Write(Result_Index[0], String_Resultado);
        Status_Clear(Result_Index[0]);
      }

      //Crea una tabla de double tipo java
      jPosition = env->NewDoubleArray(Vector64_Length);

      //Saca los elementos de la tabla
      Pos = env->GetDoubleArrayElements(jPosition, 0);

      //initializa los valores de la tabla java con el vector velocidad devuelto
      for (int i=0; i<Vector64_Length; i++) {
        Pos[i] = *position[i];
      }
      //Libera memoria
      delete[](position);
      env->ReleaseDoubleArrayElements(jPosition, Pos, 0);

      return jPosition;

    }
  ```

  </p>
  </details>

  - [How to return an array from JNI to Java?](https://stackoverflow.com/questions/1610045/how-to-return-an-array-from-jni-to-java/1610062#1610062)
  <details><summary>code</summary>
  <p>

  ```
  JNIEXPORT jintArray JNICALL Java_ArrayTest_initIntArray(JNIEnv *env, jclass cls, int size)
  {
   jintArray result;
   result = (*env)->NewIntArray(env, size);
   if (result == NULL) {
       return NULL; /* out of memory error thrown */
   }
   int i;
   // fill a temp structure to use to populate the java int array
   jint fill[size];
   for (i = 0; i < size; i++) {
       fill[i] = 0; // put whatever logic you want to populate the values here.
   }
   // move from the temp structure to the java structure
   (*env)->SetIntArrayRegion(env, result, 0, size, fill);
   return result;
  }
  ```

  </p>
  </details>
  
#### Code
- [Returning String array from C program to Java(JNI) ](https://coderanch.com/t/326467/java/Returning-String-array-program-Java):
  <details><summary>code</summary>
  <p>

  ```
    #include <jni.h>
    #include "ArrayHandler.h"

    JNIEXPORT jobjectArray JNICALL Java_ArrayHandler_returnArray(JNIEnv *env, jobject jobj) {    
      char *message[5]= {"first", 
                         "second", 
                         "third", 
                         "fourth", 
                         "fifth"};

      jobjectArray ret = (jobjectArray)env->NewObjectArray(5,
                          env->FindClass("java/lang/String"),
                          env->NewStringUTF(""));

      for(int i = 0; i < 5; i++) {
          env->SetObjectArrayElement(ret,i,env->NewStringUTF(message[i]));
      }
      return(ret);
    }
  ```

  </p>
  </details>

- [Return a String array on a JNI method](https://stackoverflow.com/questions/6047166/return-a-string-array-on-a-jni-method)
- [How to return string array to java JNI](https://stackoverflow.com/questions/52554379/how-to-return-string-array-to-java-jni)
- [jstring return in JNI program](https://stackoverflow.com/questions/13796786/jstring-return-in-jni-program)
  <details><summary>code</summary>
  <p>

  ```
  JNIEXPORT jstring JNICALL Java_Sample1_stringMethod
     (JNIEnv *env, jobject obj, jstring string) {

   const char *name = (*env).GetStringUTFChars(env,string, NULL);
   char msg[60] = "Hello ";
   jstring result;

   strcat(msg, name);  
   (*env).ReleaseStringUTFChars(env,string, name);   
   puts(msg);            
   result = (*env).NewStringUTF(env,msg); 
   return result;        
   } 
  ```

  </p>
  </details>

### JNI
- [Eliminating JNI overhead: tricks and trade-offs](https://web.archive.org/web/20190409013449/https://thinkingandcomputing.com/posts/eliminating-jni-overhead.html)
- [passing primitives array from Java to C and back](http://jnicookbook.owsiak.org/recipe-No-013/)
- [What makes JNI calls slow?](https://stackoverflow.com/questions/7699020/what-makes-jni-calls-slow)
- [Is the native method expensive? JNI Secret Extension](https://sudonull.com/post/111632-Is-the-native-method-expensive-JNI-Secret-Extension)
- [JNI Performance - Welcome to the dark side](http://normanmaurer.me/blog/2014/01/07/JNI-Performance-Welcome-to-the-dark-side/)
- [JNI is (Not) Your Friend](https://nachtimwald.com/2017/07/09/jni-is-not-your-friend/)
- [Java app calls C++ DLL via JNI; how best to allocate memory?](https://stackoverflow.com/questions/7700446/java-app-calls-c-dll-via-jni-how-best-to-allocate-memory)
- [Efficient JNI programming, part I](https://rkennke.wordpress.com/2007/07/20/efficient-jni-programming-part-i/)

### JNI and array
- [JNI array access benchmark](https://gist.github.com/apangin/af70e39b25e578d13484e937c66c7985)
- [JNI accessing array of array](https://stackoverflow.com/questions/50864027/jni-accessing-array-of-array)
- [JNI DeleteLocalRef Clarification](https://stackoverflow.com/questions/24289724/jni-deletelocalref-clarification)
- [What's the trade-off between using GetPrimitiveArrayCritical and Get<PrimitiveType>ArrayRegion?](https://stackoverflow.com/questions/23258357/whats-the-trade-off-between-using-getprimitivearraycritical-and-getprimitivety)
- [jni - Slow processing in native](https://stackoverflow.com/questions/35529437/jni-slow-processing-in-native)
- [JNI- unpinned primitve array error](https://stackoverflow.com/questions/35186512/jni-unpinned-primitve-array-error/35529203#35529203)
- [JVM Anatomy Quark #9: JNI Critical and GC Locker](https://shipilev.net/jvm/anatomy-quarks/9-jni-critical-gclocker/)

### Tutorials / Courses
- [JNI – Java Native Interface](https://electrofriends.com/category/articles/jni/)
- [Java Native Interface (JNI) - Essential Books](https://www.programming-books.io/essential/java/java-native-interface-jni-e4ecbdd24cc14fe5bfa8fd658d08f5c9)
- [Lecture 5: Introduction to JNI](http://statweb.stanford.edu/~naras/java/course/lec5/lec5.html)
- [The Java Native Interface (JNI) - IBM](https://www.ibm.com/support/knowledgecenter/SSB23S_1.1.0.2019/com.ibm.java.vm.80.doc/docs/jni.html)
- [JNI tips](https://developer.android.com/training/articles/perf-jni)
