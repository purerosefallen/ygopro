--高速决斗技能-幽灵的子弹
Duel.LoadScript("speed_duel_common.lua")
function c100730146.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730146.skill,c100730146.con,aux.Stringid(100730146,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730146.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,0,1,nil,0xb)
end
function c100730146.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730146)
	local d=Duel.CreateToken(tp,66957584)
	Duel.MoveToField(d,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	while ct>0 do
		local c=Duel.CreateToken(tp,66957584)
		Duel.SendtoDeck(c,tp,1,REASON_RULE)
		ct=ct-1
	end
	e:Reset()
end