$(function(){
    $("#s01 img").rotate({angle:30});
     
    var angle = 0;
    setInterval(function(){
                angle+=3;
             $("#s02 img").rotate(angle);
    },10);//
     
    var s03 = function (){
         $("#s03 img").rotate({
                angle: 0, 
                animateTo: 360, 
                callback: s03
         });
    }
    s03();
     
    $("#s04 img").rotate({ 
        bind: 
            { 
                click: function(){
                    $(this).rotate({
                        angle: 0,
                        animateTo: 360,
                        easing: $.easing.easeInOutExpo
                    })
                }
            } 
    });
     
    $("#s05 img").rotate({ 
    bind: 
        { 
            mouseover : function() { 
                $(this).rotate({
                    animateTo: 360
                })
            },
            mouseout : function() { 
                $(this).rotate({
                    animateTo: 0
                })
            }
        }    
    });
     
});
