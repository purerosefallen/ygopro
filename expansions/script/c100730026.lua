--高速决斗技能-命运盘
Duel.LoadScript("speed_duel_common.lua")
function c100730026.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730026.skill,c100730026.con,aux.Stringid(100730026,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730026.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
		and Duel.GetLP(tp)<=2000
end
function c100730026.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730026,0))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730026,0))
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetLabel(0)
	e1:SetCountLimit(1,100730026+100)
	e1:SetOperation(c100730026.skillwin)
	Duel.RegisterEffect(e1,tp,true)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetLabelObject(e1)
	e2:SetOperation(c100730026.skillstop)
	Duel.RegisterEffect(e2,tp,true)
	e:Reset()
end
function c100730026.skillwin(e,tp)
	local count=e:GetLabel()
	count=count+1
	e:SetLabel(count)
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730026,count))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730026,count))
	if count==5 then Duel.SetLP(1-tp,0) end
end

function c100730026.skillstop(e,tp)
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185) then return end
	e:GetLabelObject():Reset()
	e:Reset()
end