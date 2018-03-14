using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GradientScript : MonoBehaviour {

	public Image back;
	//public Material gotMat;
	Color c1, c2, c3, c4, c5, c6; //top, middle, and bottom colors
	float mid, pt;

	// Use this for initialization
	void Start () {
		if (back != null) {
			if (back.GetComponent<Image> ().material) {
				c1 = back.GetComponent<Image> ().material.GetColor ("_ColorTop");
				c2 = back.GetComponent<Image> ().material.GetColor ("_ColorMid");
				c3 = back.GetComponent<Image> ().material.GetColor ("_ColorBot");
				c4 = back.GetComponent<Image> ().material.GetColor ("_ColorH");
				c5 = back.GetComponent<Image> ().material.GetColor ("_ColorK");
				c6 = back.GetComponent<Image> ().material.GetColor ("_ColorM");
				mid = back.GetComponent<Image> ().material.GetFloat ("_Middle");
				pt = back.GetComponent<Image> ().material.GetFloat ("_Point");

				Debug.Log ("C1: " + c1);
				Debug.Log ("C2: " + c2);
				Debug.Log ("C3: " + c3);
			}
		}
	}
	
	// Update is called once per frame
	void Update () {
		//Fase + sin(ang * freq)
		c1.r = 0.75f + Mathf.Sin (Time.time) * .25f;
		c1.g = 0.5f + Mathf.Cos (Time.time) * .25f;

		c2.r = 0.5f + Mathf.Sin (Time.time) * .25f;
		c2.g = 0.5f + Mathf.Cos (Time.time) * .25f;

		c4.r = 0.75f + Mathf.Sin (Time.time) * .25f;
		c4.g = 0.5f + Mathf.Cos (Time.time) * .25f;

		c6.r = 0.5f + Mathf.Sin (Time.time) * .25f;
		c6.g = 0.5f + Mathf.Cos (Time.time) * .25f;

		mid = 0.5f + Mathf.Sin (Time.time * 0.8f) * .5f;
		pt = 0.5f + Mathf.Cos (Time.time * 0.98f) * .5f + Mathf.Sin(Time.time * 0.3f) * 0.05f;

		if (back != null) {
			back.GetComponent<Image> ().material.SetColor ("_ColorTop", c1);
			back.GetComponent<Image> ().material.SetColor ("_ColorMid", c2);
			back.GetComponent<Image> ().material.SetColor ("_ColorH", c4);
			back.GetComponent<Image> ().material.SetColor ("_ColorM", c6);
			back.GetComponent<Image> ().material.SetFloat ("_Point", pt);
			back.GetComponent<Image> ().material.SetFloat ("_Middle", mid);
		}
	}
}
