--高速决斗技能-幽灵的子弹
Duel.LoadScript("speed_duel_common.lua")
function c100730149.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730149.skill,c100730149.con,aux.Stringid(100730149,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730149.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
	and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,0,1,nil,0xb)
end
function c100730149.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730149)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if h1>0 then return end
	local d=Duel.CreateToken(tp,66957584)
	local f=Duel.CreateToken(tp,66957584)
	Duel.MoveToField(d,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.SendtoDeck(f,nil,1,REASON_RULE)
	e:Reset()
end