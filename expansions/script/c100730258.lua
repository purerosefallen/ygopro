--高速决斗技能-命运盘
Duel.LoadScript("speed_duel_common.lua")
function c100730258.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(16625614,c)
	aux.SpeedDuelAtMainPhase(c,c100730258.skill,c100730258.con,aux.Stringid(100730258,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730258.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
		and Duel.GetLP(tp)<=4000
end
function c100730258.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730258)
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730258,0))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730258,0))
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetLabel(0)
	e1:SetCountLimit(1,100730258+100)
	e1:SetOperation(c100730258.skillwin)
	Duel.RegisterEffect(e1,tp,true)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetLabelObject(e1)
	e2:SetOperation(c100730258.skillstop)
	Duel.RegisterEffect(e2,tp,true)
	e:Reset()
end
function c100730258.skillwin(e,tp)
	local count=e:GetLabel()
	count=count+1
	e:SetLabel(count)
	if count==1 then
		Duel.Hint(HINT_CARD,1-tp,94212438)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730258,count))
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730258,count))
	elseif count==2 then
		Duel.Hint(HINT_CARD,1-tp,31893528)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730258,count))
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730258,count))
	elseif count==3 then
		Duel.Hint(HINT_CARD,1-tp,67287533)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730258,count))
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730258,count))
	elseif count==4 then
		Duel.Hint(HINT_CARD,1-tp,94772232)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730258,count))
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730258,count))
	elseif count==5 then
		Duel.Hint(HINT_CARD,1-tp,30170981)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730258,count))
		Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730258,count))
		Duel.Hint(HINT_CARD,1-tp,31829185)
		Duel.Win(tp,WIN_REASON_DESTINY_BOARD)
	end
end

function c100730258.skillstop(e,tp)
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185) then return end
	e:GetLabelObject():Reset()
	e:Reset()
end