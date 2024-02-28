--高速决斗技能-螺旋枪杀
Duel.LoadScript("speed_duel_common.lua")
function c100730238.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730238.skill,c100730238.con,aux.Stringid(100730238,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730238.filter(c)
	return c:IsSetCard(0xbd) or c:IsCode(66889139) and c:IsFaceup()
end

function c100730238.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730238.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
end
function c100730238.skill(e,tp)
	Duel.Hint(HINT_CARD,1-tp,100730238)
	local d=Duel.CreateToken(tp,49328340)
	Duel.MoveToField(d,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end