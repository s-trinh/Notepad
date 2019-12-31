### Java JNI (ViSP Java binding)
- some possible interesting docs:
  - [JNI – C++ integration made easy, Evgeniy Gabrilovich, Lev Finkelstein](http://gabrilovich.com/publications/papers/cppr_jni.pdf)
  - [How to return a vector<Point> from a jni C++ function?](https://stackoverflow.com/questions/54398778/how-to-return-a-vectorpoint-from-a-jni-c-function/54399400#54399400)
  - [Wrapping a C++ library with JNI, part 4](https://thebreakfastpost.com/2012/03/06/wrapping-a-c-library-with-jni-part-4/)
  - [JNI (Java Native Interface)](https://www.jmdoudoux.fr/java/dej/chap-jni.htm)
  - [JNI Functions](https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/functions.html)
  - [Java Programming Tutorial - Java Native Interface (JNI)](https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaNativeInterface.html)
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
  
