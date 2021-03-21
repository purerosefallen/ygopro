--高速决斗技能-超能力猛攻
Duel.LoadScript("speed_duel_common.lua")
function c100730170.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730170.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730170.skill(e,tp)
   tp = e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	local d=Duel.CreateToken(tp,68077936)
	Duel.SendtoGrave(d,REASON_RULE)
	local count=1
	if Duel.TossCoin(tp,1)==1 then
		count=2
	end
	while count>0 do
		local c=Duel.CreateToken(tp,39987731)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		count=count-1
	end
	e:Reset()
end