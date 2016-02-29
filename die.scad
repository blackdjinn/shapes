// Made a die. Because. Assumes units of milimeters.
module cubicdie ($fn=50,side=13,fillet=1,rdot=1,up=0,hollow="true") {
//$fn=10;
//side=13; // Total thickness of die
//fillet=1; // how round are the corners
//rdot=1; // minimum Radius of spot
// Don't futz with what follows
face=side-2*fillet; // Face size, calculated
delta=face/3; // Dot center spacing
// Some vectors to allow precomputation.
dotgrid=[
        [[0,0,0],[0,1,0],[0,0,0]],
        [[1,0,0],[0,0,0],[0,0,1]],
        [[0,0,1],[0,1,0],[1,0,0]],
        [[1,0,1],[0,0,0],[1,0,1]],
        [[1,0,1],[0,1,0],[1,0,1]],
        [[1,1,1],[0,0,0],[1,1,1]]
    ];
 faces=[
         [[0,0,0],[0,0,1]],
         [[90,0,0],[0,1,0]],
         [[0,90,0],[1,0,0]],
         [[0,90,0],[-1,0,0]],
         [[90,0,0],[0,-1,0]],
         [[0,0,0],[0,0,-1]]
    ]; // [[rotation],[translate]] trans in in 'half side' units
 uprot=[
        [0,0,0],
        [0,0,-90],
        [90,0,90],
        [0,-90,0],
        [0,90,-90],
        [-90,0,0],
        [180,0,90]
    ];
// And here we go...
rotate(uprot[up]) difference(){
    translate((face/2)*[-1,-1,-1]){
        minkowski(){
                cube(face*[1,1,1]);
                sphere(r=fillet);
        }
    };
    for(k=[0:1:5]){
    translate((side/2)*(faces[k][1])) rotate(faces[k][0]) union(){
        for(i=[-1:1:1]){
            for(j=[-1:1:1]){
                translate(delta*[i,j,0]){
                    if(dotgrid[k][i+1][j+1]==1) sphere(r=rdot);
                }
            }
        }
    }};
    if(hollow=="true") translate((face/2)*[-1,-1,-1]) cube(face*[1,1,1]);
}};

// Test
for(i=[0:1:5]) translate(i*[15,0,0]) cubicdie($fn=10,up=i+1);